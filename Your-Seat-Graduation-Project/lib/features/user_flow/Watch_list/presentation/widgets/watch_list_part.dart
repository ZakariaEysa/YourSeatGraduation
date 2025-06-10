import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/network_image/image_replacer.dart';

class WatchListPart extends StatelessWidget {
  final String smallimage;
  final String time;
  final String title;
  final String smalltitle;
  final String image;
  final VoidCallback onRemove;

  const WatchListPart({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.smallimage,
    required this.smalltitle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Container(
        width: double.infinity,
        height: 150.0.h,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: ImageReplacer(
                imageUrl: image,
                height: 150.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            // ClipRRect(
            //   child: Image.network(
            //     image,
            //     width: 100.w,
            //     height: 150.h,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(width: 10.w), // إضافة مسافة لمنع الالتصاق
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7.h),
                    Row(
                      children: [
                        Image.asset(smallimage, width: 60.w, height: 25.h),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            smalltitle,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontSize: 14.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      time,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0XFFD9D9D9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100.h, right: 5.w),
              child: InkWell(
                onTap: onRemove,
                child: Icon(
                  Icons.cancel,
                  color: theme.colorScheme.onSecondary,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
