import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateField extends StatefulWidget {
  final String? errorText;
  final Function(String) onChanged;
  final String placeholder;
  final String? initialValue;
  final DateTime? compareWithDate;
  final bool isStartDate;

  const DateField({
    super.key,
    required this.errorText,
    required this.onChanged,
    required this.placeholder,
    this.initialValue,
    required String label,
    this.compareWithDate,
    this.isStartDate = true,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? selectedDate;
  String? displayText;

  @override
  void initState() {
    super.initState();
    _updateDisplayFromInitial(widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant DateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _updateDisplayFromInitial(widget.initialValue);
    }
  }

  void _updateDisplayFromInitial(String? value) {
    if (value != null && value.isNotEmpty) {
      displayText = value;
      selectedDate = _parseDate(value);
    } else {
      displayText = null;
      selectedDate = null;
    }
    setState(() {});
  }

  DateTime? _parseDate(String value) {
    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime oneMonthLater = now.add(const Duration(days: 30));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: oneMonthLater,
    );

    if (picked != null) {
      if (widget.compareWithDate != null) {
        if (widget.isStartDate && picked.isAfter(widget.compareWithDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Start date must be before end date 📅")),
          );
          return;
        }
        if (!widget.isStartDate && picked.isBefore(widget.compareWithDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("End date must be after start date 📅")),
          );
          return;
        }
      }

      setState(() {
        selectedDate = picked;
        displayText = _formatDate(picked);
      });
      widget.onChanged(displayText!);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
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
              displayText ?? widget.placeholder,
              style: TextStyle(
                color: displayText != null ? Colors.black : Colors.grey,
                fontSize: 4.sp,
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
