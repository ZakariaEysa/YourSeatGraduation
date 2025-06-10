import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeField extends StatefulWidget {
  final String? errorText;
  final Function(String) onChanged;
  final String placeholder;
  final String? initialValue;
  final DateTime? selectedDate;

  const TimeField({
    super.key,
    required this.errorText,
    required this.onChanged,
    required this.placeholder,
    this.initialValue,
    this.selectedDate,
    required String label,
  });

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      selectedTime = _parseTime(widget.initialValue!);
    }
  }

  TimeOfDay? _parseTime(String value) {
    try {
      final timePart = value.toLowerCase().replaceAll(' ', '');
      final isPM = timePart.contains('pm');
      final cleaned = timePart.replaceAll(RegExp(r'[^\d:]'), '');
      final parts = cleaned.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      if (isPM && hour < 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay nowTime = TimeOfDay.now();
    final DateTime now = DateTime.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? nowTime,
    );

    if (picked != null) {
      final isToday = widget.selectedDate != null &&
          widget.selectedDate!.year == now.year &&
          widget.selectedDate!.month == now.month &&
          widget.selectedDate!.day == now.day;

      // If today, block past times
      if (isToday) {
        final pickedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );

        if (pickedDateTime.isBefore(now)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You can’t select a past time')),
          );
          return; // Don’t proceed
        }
      }

      setState(() {
        selectedTime = picked;
      });
      widget.onChanged(picked.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            height: 51.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              selectedTime?.format(context) ?? widget.placeholder,
              style: TextStyle(
                color: selectedTime != null ? Colors.black : Colors.grey,
                fontSize: 5.sp,
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red, fontSize: 2.sp),
            ),
          ),
      ],
    );
  }
}
