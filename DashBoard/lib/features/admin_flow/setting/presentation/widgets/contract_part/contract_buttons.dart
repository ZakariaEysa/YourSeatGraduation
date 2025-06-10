import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../widgets/button/button_builder.dart';

class ContractButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ContractButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonBuilder(
            text: 'Save',
            onTap: onSave,
            width: 45.w,
            height: 60.h,
            buttonColor: const Color(0xFF560B76),
            frameColor: const Color(0xFF560B76),
            borderShape: BorderRadius.circular(15.r),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 8.sp,
            ),
          ),
          SizedBox(width: 20.w),
          ButtonBuilder(
            text: 'Cancel',
            onTap: onCancel,
            width: 45.w,
            height: 60.h,
            buttonColor: const Color(0xFFF3F3F3),
            frameColor: Colors.black,
            borderShape: BorderRadius.circular(15.r),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 8.sp,
            ),
          ),
        ],
      ),
    );
  }
}
