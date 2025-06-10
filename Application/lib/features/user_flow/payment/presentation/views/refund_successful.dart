import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/presentation/views/home_layout.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/button/button_builder.dart';

class RefundSuccessful extends StatelessWidget {
  const RefundSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return ScaffoldF(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 150.h),
          child: Image.asset(
            "assets/images/check .png",
            width: 209.w,
            height: 209.h,
          ),
        ),
        SizedBox(
          height: 31.h,
        ),
        Text(
          lang.refundSuccessful,
          style: theme.textTheme.labelLarge!.copyWith(fontSize: 36.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 52.h,
        ),
        ButtonBuilder(
          text: lang.ok,
          onTap: () {
            navigateTo(context: context, screen: HomeLayout());
          },
          width: 121.w,
          height: 48.h,
        )
      ],
    ));
  }
}
