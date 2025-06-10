import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/hive_keys.dart';
import '../../../../../data/hive_storage.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../../../auth/presentation/views/sign_in.dart';
import '../widgets/onboarding_content.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    var theme = Theme.of(context);
    return ScaffoldF(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, top: 10.h),
              child: SizedBox(
                height: 130.h,
                width: 250.w,
                child: Image.asset('assets/images/yourseat.png',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: getOnBoardingContents(context).length,
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (_, index) {
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(30.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            getOnBoardingContents(context)[index].image,
                            height: 300.h,
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              getOnBoardingContents(context).length,
                              (dotIndex) => buildDot(dotIndex),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            getOnBoardingContents(context)[index].title,
                            style: theme.textTheme.labelLarge!
                                .copyWith(fontSize: 35.sp),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            getOnBoardingContents(context)[index].description,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontSize: 16.sp),
                          ),
                          SizedBox(height: 40.h),
                          currentPage ==
                                  getOnBoardingContents(context).length - 1
                              ? ButtonBuilder(
                                  text: lang.startUsingTheApp,
                                  onTap: () {
                                    HiveStorage.set(
                                        HiveKeys.passUserOnboarding, true);
                                    navigateAndRemoveUntil(
                                        context: context,
                                        screen: const SignIn());
                                  },
                                  width: 300.w,
                                  height: 55.h,
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ButtonBuilder(
                                        text: lang.skip,
                                        onTap: () {
                                          HiveStorage.set(
                                              HiveKeys.passUserOnboarding,
                                              true);
                                          navigateAndRemoveUntil(
                                              context: context,
                                              screen: const SignIn());
                                        },
                                        height: 55.h,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Expanded(
                                      child: ButtonBuilder(
                                        text: lang.next,
                                        onTap: () {
                                          if (currentPage <
                                              getOnBoardingContents(context)
                                                      .length -
                                                  1) {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        height: 55.h,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // نفس مدة انتقال الصفحة
      curve: Curves.easeInOut,
      height: 10.h,
      width: currentPage == index ? 20.w : 10.w, // الدوت النشط يكبر
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: currentPage == index ? Colors.deepPurple : Colors.grey,
      ),
    );
  }
}
