import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatsGrid extends StatefulWidget {
  final Function(int) updateTotalPrice;
  final Function(int) updateSeatCategory;
  final List<String> reservedSeats;

  const SeatsGrid({
    super.key,
    required this.updateTotalPrice,
    required this.updateSeatCategory,
    required this.reservedSeats,
  });

  @override
  _SeatsGridState createState() => _SeatsGridState();
}

List<String> selectedSeats = [];

class _SeatsGridState extends State<SeatsGrid> {
  List<List<String>> seats = [];

  @override
  void initState() {
    super.initState();
    _initializeSeats();
  }

  @override
  void didUpdateWidget(covariant SeatsGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reservedSeats != oldWidget.reservedSeats) {
      _initializeSeats(); // ✅ تحديث المقاعد عند تغير `reservedSeats`
    }
  }

  void _initializeSeats() {
    int totalColumns = 13; // ✅ عدد الأعمدة مع إضافة الممر في المنتصف
    seats = List.generate(9, (_) => List.filled(totalColumns, 'a'));
    selectedSeats.clear(); // ✅ تصفير القائمة عند التحديث

    for (var seat in widget.reservedSeats) {
      int seatNumber = int.parse(seat);
      int row = seatNumber ~/ 12;
      int col = seatNumber % 12;
      if (col >= 6) col++; // ✅ تعويض الممر في الحسابات
      if (row < seats.length && col < seats[row].length) {
        seats[row][col] = 'r'; // ✅ تحديث حالة المقعد كمحجوز
      }
    }
    setState(() {});
  }

  void _selectSeat(int x, int y) {
    if (seats[x][y] == 'r') return; // ❌ لا يمكن تحديد المقعد المحجوز

    setState(() {
      int seatNumber =
          (x * 12) + (y >= 6 ? y - 1 : y); // ✅ حساب رقم المقعد الصحيح

      if (seats[x][y] == 'a') {
        widget.updateSeatCategory(x);
        widget.updateTotalPrice(_calculateSeatPrice(x));
        seats[x][y] = 's';
        selectedSeats.add(seatNumber.toString()); // ✅ إضافة الرقم إلى القائمة
      } else if (seats[x][y] == 's') {
        widget.updateTotalPrice(-_calculateSeatPrice(x));
        seats[x][y] = 'a';
        selectedSeats.remove(seatNumber.toString()); // ✅ إزالة الرقم من القائمة
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Column(
            children: List.generate(seats.length, (rowIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(seats[rowIndex].length, (colIndex) {
                  if (colIndex == 6) {
                    return SizedBox(width: 20.w); // ✅ الممر بين الجانبين
                  }
                  String seat = seats[rowIndex][colIndex];
                  String seatImage = _getSeatImage(
                      seat, context); // تعديل هنا لاستخدام الألوان من الثيم

                  return GestureDetector(
                    onTap: () => _selectSeat(rowIndex, colIndex),
                    child: Padding(
                      padding: EdgeInsets.all(4.0.sp),
                      child: Image.asset(
                        seatImage,
                        color: _getSeatColor(
                            seat, context), // إضافة اللون بناءً على الحالة
                        width: 18.w,
                        height: 18.h,
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _getSeatImage(String seat, BuildContext context) {
    switch (seat) {
      case 'a':
        return 'assets/images/avaliableSeat.png'; // الصورة للمقعد المتاح
      case 'r':
        return 'assets/images/reversedSeat.png'; // الصورة للمقعد المحجوز
      case 's':
        return 'assets/images/selectSeat.png'; // الصورة للمقعد المختار
      default:
        return 'assets/images/default.png'; // صورة الافتراضي
    }
  }

  Color _getSeatColor(String seat, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (seat) {
      case 'a':
        return colorScheme.surface; // اللون المتاح من الثيم
      case 'r':
        return colorScheme.onSurface; // اللون المحجوز من الثيم
      case 's':
        return colorScheme.surfaceVariant; // اللون المختار من الثيم
      default:
        return Colors.grey; // لو في حالة غير معرفة
    }
  }

  int _calculateSeatPrice(int row) {
    if (row < 2) return 150;
    if (row < 4) return 120;
    return 100;
  }
}
