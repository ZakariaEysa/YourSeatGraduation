import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/ticket_model.dart';
import 'ColorRingWidget.dart';
import 'booking_Item.dart';

class BookingStates extends StatefulWidget {
  const BookingStates({super.key, required this.tickets});
  final List<TicketModel> tickets;
  @override
  State<BookingStates> createState() => _BookingStatesState();
}

class _BookingStatesState extends State<BookingStates> {
  int cancelledCount = 0;
  int usedCount = 0;
  int activeCount = 0;

  String cancelledPercentage = "0";
  String usedPercentage = "0";
  String activePercentage = "0";

  void summarizeTickets(List<TicketModel> tickets) {
    final total = tickets.length;
    if (total == 0) {
      print('⚠️ No tickets to analyze.');
      return;
    }

    // ✅ عدلنا الحالة اللي تعتبر Cancelled
    cancelledCount = tickets.where((t) => t.status == 'cancelled').length;

    // ✅ النشطة = الكل - الملغاة
    activeCount = total - cancelledCount;

    // ✅ المستخدمة = اللي حالتها "active"
    usedCount = tickets.where((t) => t.status == 'active').length;

    // ✅ النسب المئوية
    activePercentage = (activeCount / total * 100).toStringAsFixed(1);
    cancelledPercentage = (cancelledCount / total * 100).toStringAsFixed(1);
    usedPercentage = (usedCount / total * 100).toStringAsFixed(1);
    if (activeCount > usedCount) {
      activeCount -= usedCount;
    }
    // ✅ طباعة للمراجعة
    print('📊 إجمالي التذاكر: $total');
    print('🟢 النشطة: $activeCount تذكرة ($activePercentage%)');
    print('🔴 الملغاة: $cancelledCount تذكرة ($cancelledPercentage%)');
    print('🟡 المستخدمة: $usedCount تذكرة ($usedPercentage%)');

    // // ✅ تحديث الواجهة
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    summarizeTickets(widget.tickets);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.w,
        height: 270.h,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Booking States",
                style: TextStyle(
                  fontSize: 5.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ColorRingWidget(),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Item(
                          percentage: widget.tickets.length.toString(),
                          color: const Color(0xFF7F33CC),
                          label: "Total Booking",
                        ),
                        Item(
                          percentage: activeCount.toString(),
                          color: const Color(0xFFC69CFF),
                          label: "Active States",
                        ),
                        Item(
                          percentage: usedCount.toString(),
                          color: const Color(0xFFE4C4FF),
                          label: "Used States",
                        ),
                        Item(
                          percentage: cancelledCount.toString(),
                          color: const Color(0xFF490073),
                          label: "Cancel States",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
