import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/application_theme/application_theme.dart';

class ThemeSheet extends StatelessWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var lang = S.of(context);
    var currentTheme =
        Provider.of<ApplicationTheme>(context); // الحصول على الثيم الحالي

    return SizedBox(
      height: 350.h,
      child: Padding(
        padding: EdgeInsets.all(35.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // زر اختيار الثيم الداكن
            GestureDetector(
              onTap: () {
                // تغيير الثيم إلى داكن إذا لم يكن الثيم الحالي هو الداكن
                if (!currentTheme.isDark) {
                  Provider.of<ApplicationTheme>(context, listen: false)
                      .toggleTheme(isDark: true);
                  navigatePop(context: context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: currentTheme.isDark
                      ? Border.all(color: Colors.white, width: 3.w)
                      : null, // إذا كان الثيم داكنًا، ضع الـ border
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang.dark,
                      style: theme.textTheme.labelLarge,
                    ),
                    if (currentTheme
                        .isDark) // إذا كان الثيم داكنًا، عرض علامة "الصح"
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            // زر اختيار الثيم الفاتح
            GestureDetector(
              onTap: () {
                // تغيير الثيم إلى فاتح إذا لم يكن الثيم الحالي هو الفاتح
                if (currentTheme.isDark) {
                  Provider.of<ApplicationTheme>(context, listen: false)
                      .toggleTheme(isDark: false);
                  navigatePop(context: context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: !currentTheme.isDark
                      ? Border.all(color: Colors.white, width: 3.w)
                      : null, // إذا كان الثيم فاتحًا، ضع الـ border
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang.light,
                      style: theme.textTheme.labelLarge,
                    ),
                    if (!currentTheme
                        .isDark) // إذا كان الثيم فاتحًا، عرض علامة "الصح"
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
