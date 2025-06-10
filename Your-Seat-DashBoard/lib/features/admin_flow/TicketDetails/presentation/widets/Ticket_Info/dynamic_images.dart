import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicImage extends StatelessWidget {
  final String imageSource;

  const DynamicImage({super.key, required this.imageSource});

  bool _isBase64(String str) {
    // نحاول نفك تشفير Base64 للتأكد إنها مش URL
    try {
      base64.decode(str);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (_isBase64(imageSource)) {
      Uint8List imageBytes = base64.decode(imageSource);
      imageWidget = Image.memory(
        imageBytes,
        width: 75.w,
        height: 173.h,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Image.network(
        imageSource,
        width: 75.w,
        height: 173.h,
        fit: BoxFit.cover,
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 40.h, left: 10.w),
      child: imageWidget,
    );
  }
}
