import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';

class ContractFileInfo extends StatelessWidget {
  final PlatformFile file;

  const ContractFileInfo({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📎 ${file.name}",
            style: TextStyle(
              fontSize: 5.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Size: ${(file.size / 1024).toStringAsFixed(2)} KB",
            style: TextStyle(
              fontSize: 4.sp,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
