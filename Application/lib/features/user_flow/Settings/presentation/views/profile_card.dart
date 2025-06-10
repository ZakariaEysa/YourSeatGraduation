import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/hive_keys.dart';
import '../../../../../utils/dialog_utilits.dart';
import '../../../../../utils/navigation.dart';
import '../../../auth/presentation/views/sign_in.dart';
import '../widgets/profile_card/profile_edit_card.dart';
import '../../../settings/presentation/widgets/profile_card/personal_info_card.dart';
import '../../../../../data/hive_storage.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  var currentUser;

  @override
  Widget build(BuildContext context) {
    // AppLogs.successLog((HiveStorage.get(HiveKeys.role) == Role.email.toString()).toString()); // Removed: was used for logging role check
    var theme = Theme.of(context);

    if (HiveStorage.get(HiveKeys.role) == Role.google.toString()) {
      setState(() {
        currentUser = HiveStorage.getGoogleUser();
      });
      setState(() {});
    } else {
      setState(() {
        currentUser = HiveStorage.getDefaultUser();
      });
      // AppLogs.successLog(currentUser.toString()); // Removed: was used for logging current user
    }

    var lang = S.of(context);
    return ScaffoldF(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () async {
                if (HiveStorage.get(HiveKeys.role) == Role.guest.toString()) {
                  DialogUtils.showMessage(
                      context, "You Have To Sign In To Continue",
                      isCancelable: false,
                      posActionTitle: lang.sign_in,
                      negActionTitle: lang.cancel, posAction: () {
                    HiveStorage.set(HiveKeys.role, "");

                    navigateAndRemoveUntil(
                      context: context,
                      screen: const SignIn(),
                    );
                  }, negAction: () {
                    navigatePop(context: context);
                  });
                } else {
                  navigateTo(
                    context: context,
                    screen: const ProfileEditCard(),
                  );
                }

                setState(() {
                  currentUser =
                      HiveStorage.get(HiveKeys.role) == Role.google.toString()
                          ? HiveStorage.getGoogleUser()
                          : HiveStorage.getDefaultUser();
                });
              },
              child: HiveStorage.get(HiveKeys.role) == Role.google.toString()
                  ? Container()
                  : Icon(
                      Icons.edit,
                      size: 27.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
          SizedBox(
            width: 12.w,
          ),
        ],
        iconTheme: IconThemeData(
          size: 28.sp,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
            child: Container(
              margin: EdgeInsets.only(top: 40.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(51.r),
                  topRight: Radius.circular(48.r),
                ),
                color: Theme.of(context)
                    .colorScheme
                    .secondaryFixed
                    .withOpacity(0.9),
                border: Border.all(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                  width: 1.w,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100.h, left: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        textAlign: TextAlign.center,
                        currentUser?.name ?? "-",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          alignment: Alignment.center,
                          width: 150.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text(
                            lang.personalInfo,
                            textAlign: TextAlign.start,
                            style: theme.textTheme.titleLarge!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      PersonalInfoCard(
                        title: lang.email,
                        icon: "assets/images/email 2.png",
                        info: currentUser?.email ?? "-",
                      ),
                      SizedBox(height: 20.h),
                      PersonalInfoCard(
                        title: lang.birthDate,
                        icon: "assets/icons/birthday_cake.png",
                        info: currentUser?.dateOfBirth ?? "-",
                      ),
                      SizedBox(height: 20.h),
                      PersonalInfoCard(
                        title: lang.gender,
                        icon: "assets/icons/gender.png",
                        info: currentUser?.gender ?? "-",
                      ),
                      SizedBox(height: 20.h),
                      PersonalInfoCard(
                        title: lang.location,
                        icon: "assets/icons/location.png",
                        info: currentUser?.location ?? "-",
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 105.w,
            child: CircleAvatar(
              radius: 80.r,
              backgroundImage:
                  currentUser?.image != null && currentUser.image.isNotEmpty
                      ? MemoryImage(base64Decode(currentUser.image))
                      : const AssetImage("assets/images/account.png")
                          as ImageProvider,
            ),
          ),
        ],
      ),
    );
  }
}
