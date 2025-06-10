import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/transactions/widgets/sales_card.dart';

class SalesContainer extends StatefulWidget {
  const SalesContainer({super.key, required this.status});
  final Map<String, int> status;

  @override
  State<SalesContainer> createState() => _SalesContainerState();
}

class _SalesContainerState extends State<SalesContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700.w,
        height: 310.h,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sales Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF737791),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SalesCard(
                        title: 'Complete Transactions',
                        value: widget.status["completed"].toString(),
                        color: const Color(0xFFFFE2E5),
                        imagePath: 'assets/images/sale1.png',
                      ),
                      SalesCard(
                        title: 'Refund Transactions',
                        value: widget.status["refunded"].toString(),
                        color: const Color(0xFFFFF4DE),
                        imagePath: 'assets/images/sale2.png',
                      ),
                      SalesCard(
                        title: 'Total Amount',
                        value: widget.status["total"].toString(),
                        color: const Color(0xFFDCFCE7),
                        imagePath: 'assets/images/sale3.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
