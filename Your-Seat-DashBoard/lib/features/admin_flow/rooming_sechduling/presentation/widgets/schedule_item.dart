import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem {
  String room;
  String movie;
  String startDate;
  String startTime;
  String endDate;
  String endTime;

  ScheduleItem({
    required this.room,
    required this.movie,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });
}

class RoomSchedulePage extends StatefulWidget {
  final List<ScheduleItem> scheduleItems;

  const RoomSchedulePage({super.key, required this.scheduleItems});

  @override
  State<RoomSchedulePage> createState() => _RoomSchedulePageState();
}

class _RoomSchedulePageState extends State<RoomSchedulePage> {
  void _editItem(ScheduleItem item) {
    final roomController = TextEditingController(text: item.room);
    final movieController = TextEditingController(text: item.movie);
    final startDateController = TextEditingController(text: item.startDate);
    final startTimeController = TextEditingController(text: item.startTime);
    final endDateController = TextEditingController(text: item.endDate);
    final endTimeController = TextEditingController(text: item.endTime);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الجدول'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: roomController,
                  decoration: const InputDecoration(labelText: 'Room')),
              TextField(
                  controller: movieController,
                  decoration: const InputDecoration(labelText: 'Movie')),
              TextField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                      labelText: 'Start Date (yyyy-MM-dd)')),
              TextField(
                  controller: startTimeController,
                  decoration:
                      const InputDecoration(labelText: 'Start Time (HH:mm)')),
              TextField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                      labelText: 'End Date (yyyy-MM-dd)')),
              TextField(
                  controller: endTimeController,
                  decoration:
                      const InputDecoration(labelText: 'End Time (HH:mm)')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final newRoom = roomController.text;
              final newMovie = movieController.text;
              final newStartDate = startDateController.text;
              final newStartTime = startTimeController.text;
              final newEndDate = endDateController.text;
              final newEndTime = endTimeController.text;

              bool isDuplicate = widget.scheduleItems.any((other) =>
                  other != item &&
                  other.room.trim().toLowerCase() ==
                      newRoom.trim().toLowerCase() &&
                  other.movie.trim().toLowerCase() ==
                      newMovie.trim().toLowerCase() &&
                  other.startDate.trim() == newStartDate.trim() &&
                  other.startTime.trim() == newStartTime.trim() &&
                  other.endDate.trim() == newEndDate.trim() &&
                  other.endTime.trim() == newEndTime.trim());

              if (isDuplicate) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('تنبيه'),
                    content: const Text('هذا الجدول موجود بالفعل!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('حسناً'),
                      ),
                    ],
                  ),
                );
                return;
              }
              setState(() {
                item.room = roomController.text;
                item.movie = movieController.text;
                item.startDate = startDateController.text;
                item.startTime = startTimeController.text;
                item.endDate = endDateController.text;
                item.endTime = endTimeController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.scheduleItems.sort((a, b) {
      try {
        final dateTimeA = DateFormat('yyyy-MM-dd HH:mm')
            .parse('${a.startDate} ${a.startTime}');
        final dateTimeB = DateFormat('yyyy-MM-dd HH:mm')
            .parse('${b.startDate} ${b.startTime}');
        return dateTimeB.compareTo(dateTimeA);
      } catch (e) {
        return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Schedule"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'هنا ممكن تضيف جدول العرض باستخدام Widget خارجي زي ScheduleTable',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
