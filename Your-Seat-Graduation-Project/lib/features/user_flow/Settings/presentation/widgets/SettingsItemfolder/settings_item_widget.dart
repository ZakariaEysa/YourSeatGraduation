import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/l10n.dart';

class SettingsItemClass extends StatelessWidget {
  final String title;
  final String imageIcon;
  final VoidCallback? onPress;

  const SettingsItemClass({
    super.key,
    required this.title,
    required this.imageIcon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    S.of(context);
    return InkWell(
      onTap: onPress,
      borderRadius:
          BorderRadius.circular(20.r), // علشان يعطي تأثير ناعم على الحواف
      child: Container(
        alignment: Alignment.centerLeft,
        width: 304.w,
        height: 70.h,
        padding: EdgeInsets.all(16.sp),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imageIcon,
              width: 25.w,
              height: 25.h,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 22,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: theme.colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
