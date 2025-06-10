import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';

class Date extends StatefulWidget {
  final List<int> days;
  final List<int> months;
  final int selectedDay;
  final List<int> years; // ✅ أضف هذا المتغير

  final Function(int, int, int)
      onDaySelected; // ✅ عدّل هنا ليستقبل (يوم، شهر، سنة)

  const Date({
    super.key,
    required this.days,
    required this.months,
    required this.selectedDay,
    required this.onDaySelected,
    required this.years,
  });

  @override
  _DateState createState() => _DateState();
}

class _DateState extends State<Date> {
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final List<String> months = [
      lang.jan,
      lang.feb,
      lang.mar,
      lang.apr,
      lang.may,
      lang.jun,
      lang.jul,
      lang.aug,
      lang.sep,
      lang.oct,
      lang.nov,
      lang.dec
    ];

    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.days.length,
        itemBuilder: (context, index) {
          int dayInMonth = widget.days[index];
          int monthIndex = widget.months[index] - 1;
          int year = widget.years[index]; // ✅ أضف السنة

          String formattedDay = dayInMonth.toString().padLeft(2, '0');
          String formattedMonth = months[monthIndex];

          bool isSelected = dayInMonth == widget.selectedDay;

          return GestureDetector(
            onTap: () {
              widget.onDaySelected(dayInMonth, widget.months[index],
                  year); // ✅ رجّع اليوم، الشهر، والسنة
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.w),
              child: Container(
                width: 59.w,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF09FBD3) : Color(0xFF1D1D1D),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.sp),
                    Text(
                      formattedMonth,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      width: 56.w,
                      height: 54.5.h,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1D1D1D)
                            : const Color(0xFF3B3B3B),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          formattedDay,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
