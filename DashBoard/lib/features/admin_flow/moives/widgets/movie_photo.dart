import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoviePhoto extends StatelessWidget {
  final String imagePath;
  final bool isNetworkImage;

  const MoviePhoto({
    super.key,
    required this.imagePath,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: isNetworkImage
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
