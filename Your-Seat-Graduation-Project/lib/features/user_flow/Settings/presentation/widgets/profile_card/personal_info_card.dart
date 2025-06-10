import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/l10n.dart';

class PersonalInfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String? info;

  const PersonalInfoCard({
    super.key,
    required this.icon,
    required this.title,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    S.of(context);
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageIcon(
            AssetImage(
              icon,
            ),
            size: 25.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(
            width: 18,
          ),
          Text(
            title,
            style: theme.textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 20.sp),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                info ?? "",
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 13.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
