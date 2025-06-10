import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/network_image/image_replacer.dart';

class Director extends StatelessWidget {
  final String name;
  final String imagePath;

  const Director({
    super.key,
    required this.name,
    required this.imagePath,
  });

  bool isBase64(String? imageUrl) {
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/=]+$');
    return base64Pattern.hasMatch(imageUrl ?? "https://picsum.photos/150/130");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // AppLogs.errorLog("00000000000000000000000"); // Removed: was used for logging an error in Director widget
    // print(imagePath); // Removed: was used for debugging imagePath in Director widget
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 13.w),
        child: Container(
          height: 58.h,
          decoration: BoxDecoration(
            color: const Color(0xFF7427BF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 5.w),
                child: isBase64(imagePath)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.memory(
                          base64Decode(imagePath),
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ImageReplacer(
                        imageUrl: imagePath,
                        fit: BoxFit.fill,
                        isCircle: true,
                        width: 50.w,
                        height: 50.h,
                      ),
              ),
              SizedBox(width: 2.w),
              Padding(
                padding: EdgeInsets.only(right: 12.w, left: 11.w),
                child: Text(name,
                    style:
                        theme.textTheme.titleLarge!.copyWith(fontSize: 12.sp)),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
