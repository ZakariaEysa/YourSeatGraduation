import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/local_storage_service/local_storage_service.dart';
import '../widgets/schedule_item.dart';

class RoomingScheduling extends StatefulWidget {
  RoomingScheduling({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchScheduleSummaryFromFirebase() async {
    try {
      final String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");
      final DocumentReference cinemaDoc =
          _firestore.collection('Cinemas').doc(cinemaId);
      final DocumentSnapshot cinemaSnapshot = await cinemaDoc.get();

      if (!cinemaSnapshot.exists) {
        throw Exception("Cinema document does not exist.");
      }

      final Map<String, dynamic> data =
          cinemaSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> moviesList = data['movies'] ?? [];

      List<Map<String, dynamic>> scheduleSummaries = [];

      for (final movie in moviesList) {
        if (movie is Map<String, dynamic>) {
          final String movieName = movie['name'] ?? 'Unnamed';
          final List<dynamic> times = movie['times'] ?? [];

          if (times.isEmpty) continue;

          final Map<String, List<Map<String, dynamic>>> hallGroups = {};

          for (var timeEntry in times) {
            final String hall = timeEntry['hall'];
            if (!hallGroups.containsKey(hall)) {
              hallGroups[hall] = [];
            }
            hallGroups[hall]!.add(timeEntry);
          }

          for (final hall in hallGroups.keys) {
            final hallTimes = hallGroups[hall]!;
            hallTimes.sort((a, b) => a['date'].compareTo(b['date']));

            final String startDate = hallTimes.first['date'];
            final String endDate = hallTimes.last['date'];

            final firstDayTimes = (hallTimes.first['time'] as List)
                .map((t) => t['time'].toString())
                .toList();
            firstDayTimes.sort();
            final String startTime = firstDayTimes.first;

            final lastDayTimes = (hallTimes.last['time'] as List)
                .map((t) => t['time'].toString())
                .toList();
            lastDayTimes.sort();
            final String endTime = lastDayTimes.last;

            scheduleSummaries.add({
              'movie': movieName,
              'hall': hall,
              'startDate': startDate,
              'endDate': endDate,
              'startTime': startTime,
              'endTime': endTime,
            });
          }
        }
      }

      print('✅ Schedule summary fetched with hall info.');
      return scheduleSummaries;
    } catch (e) {
      print('❌ Error fetching schedule summary: $e');
      return [];
    }
  }

  Future<void> deleteScheduleFromFirebase(String movieName, String hall) async {
    try {
      final String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");
      final DocumentReference cinemaDoc =
          _firestore.collection('Cinemas').doc(cinemaId);
      final DocumentSnapshot cinemaSnapshot = await cinemaDoc.get();

      if (!cinemaSnapshot.exists) {
        throw Exception("Cinema document does not exist.");
      }

      final Map<String, dynamic> data =
          cinemaSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> moviesList = data['movies'] ?? [];

      final int movieIndex = moviesList.indexWhere(
        (movie) => movie is Map && movie['name'] == movieName,
      );

      if (movieIndex == -1) {
        throw Exception("Movie not found");
      }

      final movie = Map<String, dynamic>.from(moviesList[movieIndex]);
      final List<dynamic> times = movie['times'] ?? [];

      // احذف كل الأوقات المتعلقة بالقاعة المحددة
      times.removeWhere((time) => time['hall'] == hall);

      movie['times'] = times;
      moviesList[movieIndex] = movie;

      await cinemaDoc.update({'movies': moviesList});

      print("✅ Schedule deleted successfully from Firebase.");
    } catch (e) {
      print("❌ Error deleting schedule: $e");
    }
  }

  String extractUsername(String email) {
    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  @override
  State<RoomingScheduling> createState() => _RoomingSchedulingState();
}

class _RoomingSchedulingState extends State<RoomingScheduling> {
  List<ScheduleItem> _scheduleItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSchedule();
  }

  void loadSchedule() async {
    final schedulesData = await widget.fetchScheduleSummaryFromFirebase();
    setState(() {
      _scheduleItems = schedulesData
          .map((e) => ScheduleItem(
                room: e['hall'] ?? '',
                movie: e['movie'] ?? '',
                startDate: e['startDate'] ?? '',
                startTime: e['startTime'] ?? '',
                endDate: e['endDate'] ?? '',
                endTime: e['endTime'] ?? '',
              ))
          .toList();
      _isLoading = false;
    });
  }

  void _deleteItem(ScheduleItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Schedule"),
        content: const Text("Are you sure you want to delete this schedule?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                _scheduleItems.remove(item);
              });
              await widget.deleteScheduleFromFirebase(item.movie, item.room);
              loadSchedule();
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.75),
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(Colors.grey.withOpacity(0.1)),
              dataRowMaxHeight: 50,
              columnSpacing: 1,
              headingTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 5.sp),
              dataTextStyle: const TextStyle(color: Colors.black),
              columns: const [
                DataColumn(label: Text('Room')),
                DataColumn(label: Text('Movie')),
                DataColumn(label: Text('Start Date')),
                DataColumn(label: Text('Start Time')),
                DataColumn(label: Text('End Date')),
                DataColumn(label: Text('End Time')),
                DataColumn(label: Text('Action')),
              ],
              rows: _scheduleItems.map((item) {
                return DataRow(cells: [
                  DataCell(Text(item.room)),
                  DataCell(Text(item.movie)),
                  DataCell(Text(item.startDate)),
                  DataCell(Text(item.startTime)),
                  DataCell(Text(item.endDate)),
                  DataCell(Text(item.endTime)),
                  DataCell(
                    Center(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteItem(item),
                          ),
                        ],
                      ),
                    ),
                  )
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
