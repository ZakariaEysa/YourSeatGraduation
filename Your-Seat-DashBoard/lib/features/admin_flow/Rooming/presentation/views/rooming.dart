import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../rooming_sechduling/presentation/widgets/schedule_item.dart';
import '../widgets/date_time/date_screen.dart';
import '../widgets/rooming_validator.dart';

class Rooming extends StatefulWidget {
  final List<ScheduleItem> scheduleItems;

  const Rooming({super.key, required this.scheduleItems});

  @override
  State<Rooming> createState() => _RoomingState();
}

class _RoomingState extends State<Rooming> {
  final GlobalKey<DateTimeFieldsState> dateTimeKey = GlobalKey();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String extractUsername(String email) {
    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  Future<void> saveScheduleToFirebase(List<ScheduleItem> items) async {
    try {
      final String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");
      final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat timeFormat = DateFormat('HH:mm');

      final DocumentReference cinemaDoc =
          _firestore.collection('Cinemas').doc(cinemaId);
      final DocumentSnapshot cinemaSnapshot = await cinemaDoc.get();

      if (!cinemaSnapshot.exists) {
        throw Exception("Cinema document does not exist.");
      }

      final Map<String, dynamic> existingData =
          cinemaSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> moviesList = existingData['movies'] ?? [];

      for (final item in items) {
        final String movieName = item.movie;
        final DateTime startDate = inputFormat.parse(item.startDate);
        final DateTime endDate = inputFormat.parse(item.endDate);
        final String hall = item.room;
        final String startTimeStr = item.startTime;

        final int movieIndex = moviesList.indexWhere(
          (movie) => movie is Map && movie['name'] == movieName,
        );

        if (movieIndex == -1) {
          print('❌ Movie "$movieName" not found in the list.');
          continue;
        }

        final movie = Map<String, dynamic>.from(moviesList[movieIndex]);

        // استخراج مدة الفيلم من String مثل "120m"
        final String? durationStr = movie['duration'] as String?;
        if (durationStr == null || !RegExp(r'^\d+m$').hasMatch(durationStr)) {
          print('❌ Invalid or missing duration for movie "$movieName".');
          continue;
        }
        final int duration = int.parse(durationStr.replaceAll('m', ''));

        // المدة النهائية بعد إضافة نصف ساعة
        final int interval = duration + 30;

        // تحويل وقت البداية إلى DateTime
        final DateTime startTime = timeFormat.parse(startTimeStr);

        List<Map<String, dynamic>> schedule =
            (movie['times'] as List?)?.cast<Map<String, dynamic>>() ?? [];

        for (DateTime date = startDate;
            !date.isAfter(endDate);
            date = date.add(const Duration(days: 1))) {
          final formattedDate = outputFormat.format(date);
          DateTime currentTime = DateTime(date.year, date.month, date.day,
              startTime.hour, startTime.minute);
          final DateTime endOfDay =
              DateTime(date.year, date.month, date.day, 23, 59);

          final existingEntry = schedule.firstWhere(
            (entry) => entry['date'] == formattedDate && entry['hall'] == hall,
            orElse: () => {},
          );

          List<Map<String, dynamic>> timesList = [];

          // إذا كان هناك مدخل قديم، اجلب الأوقات القديمة
          if (existingEntry.isNotEmpty) {
            timesList =
                (existingEntry['time'] as List).cast<Map<String, dynamic>>();
            schedule.removeWhere((entry) =>
                entry['date'] == formattedDate && entry['hall'] == hall);
          }

          while (currentTime.isBefore(endOfDay)) {
            timesList.add({'time': timeFormat.format(currentTime)});
            currentTime = currentTime.add(Duration(minutes: interval));
          }

          schedule.add({
            'date': formattedDate,
            'hall': hall,
            'time': timesList,
          });
        }

        movie['times'] = schedule;
        moviesList[movieIndex] = movie;
      }

      await cinemaDoc.update({'movies': moviesList});
      print('✅ Schedule updated inside movies list successfully.');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Schedule saved inside movies list!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('❌ Error saving schedule inside movies list: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving schedule: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void addSchedule() {
    final dateTimeFieldsState = dateTimeKey.currentState;
    if (dateTimeFieldsState == null) return;

    final items = dateTimeFieldsState.getAllSchedules();

    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all information correctly.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final validationMessage = RoomingValidator.validateScheduleItems(items);
    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final conflictMessage =
        RoomingValidator.checkConflictWithExisting(widget.scheduleItems, items);
    if (conflictMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(conflictMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final existingKeys = widget.scheduleItems
        .map((item) =>
            '${item.room}|${item.movie}|${item.startDate}|${item.startTime}|${item.endDate}|${item.endTime}')
        .toSet();

    final newItems = items.where((item) {
      final key =
          '${item.room}|${item.movie}|${item.startDate}|${item.startTime}|${item.endDate}|${item.endTime}';
      return !existingKeys.contains(key);
    }).toList();

    if (newItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This schedule already exists.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      widget.scheduleItems.insertAll(0, newItems);
    });

    saveScheduleToFirebase(newItems);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Schedules added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              DateTimeFields(
                key: dateTimeKey,
              ),
              SizedBox(height: screenHeight * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Add',
                    onTap: addSchedule,
                    width: 40.w,
                    height: 50.h,
                    buttonColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 7.sp),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
