// date_time_fields.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../rooming_sechduling/presentation/widgets/schedule_item.dart';
import 'Date_Time_Fields_Controller.dart';
import 'date_time_group_row.dart';

class DateTimeFields extends StatefulWidget {
  const DateTimeFields({super.key});

  @override
  State<DateTimeFields> createState() => DateTimeFieldsState();
}

class DateTimeFieldsState extends State<DateTimeFields> {
  final controller = DateTimeFieldsController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 65.h, left: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < controller.dateTimePairs.length; i += 2)
            DateTimeGroupRow(
              startIndex: i,
              dateTimePairs: controller.dateTimePairs,
              dateErrors: controller.dateErrors,
              timeErrors: controller.timeErrors,
              onRemove: (index) {
                setState(() {
                  controller.removeDateTimeGroup(index);
                });
              },
              onUpdate: () => setState(() {}),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.add_circle_outline,
                  color: Colors.black, size: 5.sp),
              onPressed: () {
                setState(() {
                  controller.addDateTimePair();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  List<ScheduleItem> getAllSchedules() => controller.getAllSchedules();
}
