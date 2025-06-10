import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/l10n.dart';

class SelectedOptionWidget extends StatelessWidget {
  final String selectedTitle;
  const SelectedOptionWidget({required this.selectedTitle, super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.white, width: 3.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedTitle,
            style: theme.textTheme.labelLarge,
          ),
          Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 25.sp,
          )
        ],
      ),
    );
  }
}
