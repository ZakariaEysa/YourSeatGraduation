import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../moives/widgets/movie_photo.dart';

class MovieCell extends StatelessWidget {
  final String imagePath;
  final String title;

  const MovieCell({required this.imagePath, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          MoviePhoto(imagePath: imagePath),
          SizedBox(width: 1.w),
          Flexible(
            child: Text(
              title,
              style: TextStyle(color: Colors.black87, fontSize: 5.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
