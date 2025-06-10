import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../widgets/button/button_builder.dart';

class PDFSection extends StatelessWidget {
  final PlatformFile? pickedPdf;
  final VoidCallback onPick;
  final VoidCallback onDelete;

  const PDFSection({
    super.key,
    required this.pickedPdf,
    required this.onPick,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text("upload PDF",
                style:
                    TextStyle(color: const Color(0xFF6A6767), fontSize: 5.sp)),
            SizedBox(height: 5.h),
            SizedBox(
              width: 50.w,
              height: 130.h,
              child: pickedPdf != null
                  ? Icon(Icons.picture_as_pdf, size: 30.sp, color: Colors.red)
                  : Image.asset("assets/icons/download 1.png",
                      fit: BoxFit.contain),
            ),
            if (pickedPdf != null) ...[
              SizedBox(height: 5.h),
              SizedBox(
                width: 50.w,
                child: Text(
                  pickedPdf!.name,
                  style: TextStyle(
                      fontSize: 4.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "Size: ${(pickedPdf!.size / 1024).toStringAsFixed(2)} KB",
                style: TextStyle(fontSize: 3.sp, color: Colors.black),
              ),
            ],
            SizedBox(height: 10.h),
            Text("*PDF maximum 10 MB .",
                style:
                    TextStyle(fontSize: 3.sp, color: const Color(0xFF6A6767))),
          ],
        ),
        SizedBox(width: 3.w),
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ButtonBuilder(
                    text: pickedPdf == null ? 'Upload' : 'Change',
                    onTap: onPick,
                    width: 30.w,
                    height: 51.h,
                    buttonColor: const Color(0xFF292D32),
                    frameColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(15.r),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 5.sp),
                  ),
                  SizedBox(width: 3.w),
                  ButtonBuilder(
                    text: 'Delete',
                    onTap: onDelete,
                    width: 25.w,
                    height: 40.h,
                    buttonColor: const Color(0xFFFF0000),
                    borderShape: BorderRadius.circular(15.r),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 5.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
