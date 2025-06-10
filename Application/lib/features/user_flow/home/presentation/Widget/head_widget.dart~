import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Notifaction/views/Notifaction.dart';
import '../../../../../utils/navigation.dart';
import '../../../Rate/Rate.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 120.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/yourseat.png",
            width: 190.w,
            height: 120.h,
          ),
          GestureDetector(
            onTap: () {
              // navigateTo(context: context, screen:  Notifications());
              navigateTo(context: context, screen:  Rate());

            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/icons/notification_icon.png",
                width: 36.w,
                height: 115.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
