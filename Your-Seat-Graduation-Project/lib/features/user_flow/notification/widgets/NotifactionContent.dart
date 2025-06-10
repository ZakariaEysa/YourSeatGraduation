import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String body;
  final String time;
  final String? numOfNotification;

  const NotificationContent({
    super.key,
    required this.imagePath,
    this.title = 'SALE IS LIVE',
    required this.body,
    required this.time,
    this.numOfNotification,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (numOfNotification != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7443A),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            numOfNotification!,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 22.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      body,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
