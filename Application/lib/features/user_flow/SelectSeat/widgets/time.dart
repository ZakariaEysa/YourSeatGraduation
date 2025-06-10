import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Time extends StatefulWidget {
  final List<Map<String, dynamic>> times;
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const Time({
    super.key,
    required this.times,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.times.length,
        itemBuilder: (context, index) {
          String timeValue = widget.times[index]["time"];
          bool isSelected = timeValue == widget.selectedTime;

          return GestureDetector(
            onTap: () {
              widget.onTimeSelected(timeValue);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF321131)
                    : const Color(0xFF1E1E1E),
                border: isSelected
                    ? Border.all(color: const Color(0xFF09FBD3), width: 2.w)
                    : null,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  timeValue,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 18.sp),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
