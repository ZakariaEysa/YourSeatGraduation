import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../../../home/presentation/views/home_layout.dart';

class ChatUp extends StatelessWidget {
  const ChatUp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var lang = S.of(context);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsetsDirectional.only(top: 50.h, start: 20.w, end: 20.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  navigateTo(context: context, screen: HomeLayout());
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                ),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const Spacer(),
              Image.asset(
                'assets/images/chat_bot.png',
                width: 70.w,
                height: 70.h,
                // color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsetsDirectional.only(top: 10.h, start: 20.w, end: 20.w),
          child: Text(
            lang.HelloIamyourAIAssistant,
            style: theme.textTheme.bodyLarge!.copyWith(fontSize: 28.sp),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
