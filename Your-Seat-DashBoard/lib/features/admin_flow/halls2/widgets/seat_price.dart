import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_input.dart';

class SeatPrice extends StatelessWidget {
  final TextEditingController vipController;
  final TextEditingController premiumController;
  final TextEditingController standardController;
  final String? vipError;
  final String? premiumError;
  final String? standardError;
  final VoidCallback? onChanged;

  const SeatPrice({
    super.key,
    required this.vipController,
    required this.premiumController,
    required this.standardController,
    this.vipError,
    this.premiumError,
    this.standardError,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(9.r),
      ),
      padding: EdgeInsets.all(2.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price for seat",
            style: TextStyle(
              fontSize: 5.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SeatInput(
                  label: 'VIP',
                  color: const Color(0xFFA79F06),
                  controller: vipController,
                  errorText: vipError,
                  onChanged: (value) => onChanged?.call(),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: SeatInput(
                  label: 'Premium',
                  color: const Color(0xFFFF5E3A),
                  controller: premiumController,
                  errorText: premiumError,
                  onChanged: (value) => onChanged?.call(),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: SeatInput(
                  label: 'Standard',
                  color: Colors.blueAccent,
                  controller: standardController,
                  errorText: standardError,
                  onChanged: (value) => onChanged?.call(),
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
