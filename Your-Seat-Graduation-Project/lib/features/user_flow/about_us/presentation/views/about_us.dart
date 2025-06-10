import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resources/constants.dart';
import '../../../../../widgets/app_bar/head_appbar.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/row_of_social_items.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);

    return ScaffoldF(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 28.sp, // ضبط حجم الأيقونة باستخدام ScreenUtil
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(45, 0, 0, 20),
          child: HeadAppBar(
            title: lang.AboutUs,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: 65.h), // ضبط المسافة العلوية باستخدام ScreenUtil
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/images/${AppConstVariables.aboutUsImg}"),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomSheet(
                scrollController: DraggableScrollableController(),
                title: lang.TermsAndConditions,
                content: lang.termsAndConditionsContent,
                initialHeight: .34,
                maxHeight: .98,
                minHeight: .34,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomSheet(
                scrollController: DraggableScrollableController(),
                title: lang.PrivacyPolicy,
                content: lang.privacyPolicyContent,
                initialHeight: .24,
                maxHeight: .89,
                minHeight: .24,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomSheet(
                scrollController: DraggableScrollableController(),
                title: lang.contactUs,
                content: lang.contactUsContent,
                initialHeight: .15,
                maxHeight: .82,
                minHeight: .15,
                bottomWidget: const RowOfSocialItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
