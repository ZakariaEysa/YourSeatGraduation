import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../resources/constants.dart';
import 'social_items.dart';

class RowOfSocialItems extends StatelessWidget {
  const RowOfSocialItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialItem(
          linkUrl: "https://www.facebook.com/profile.php?id=61567367565000",
          imageUrl: "assets/images/${AppConstVariables.facebookImg}",
        ),
        SizedBox(width: 22.w), // استخدام ScreenUtil لضبط التباعد
        SocialItem(
          linkUrl: "mailto:yourseatgp@gmail.com",
          imageUrl: "assets/images/${AppConstVariables.emailImg}",
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        SizedBox(width: 22.w), // استخدام ScreenUtil لضبط التباعد
        SocialItem(
          linkUrl: "tel:+201091058098", // دعم رقم الهاتف مع أو بدون "tel:"
          imageUrl: "assets/icons/${AppConstVariables.phone}",
        ),
      ],
    );
  }
}
