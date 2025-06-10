import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../utils/validation_utils.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/loading_indicator.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../../../../../widgets/text_field/text_field/text_form_field_builder.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/sign_in_logic.dart';
import '../widgets/sign_in_part.dart';
import 'forget.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscure2 = true;

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    var lang = S.of(context);
    final theme = Theme.of(context);

    return ScaffoldF(
      appBar: AppBar(title: Text(lang.sign_in)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) =>
                  SignInLogic.handleAuthState(context, state),
              builder: (context, state) {
                return Form(
                  key: cubit.formKeyLogin,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 25.h),
                      FadeInRight(
                        delay: const Duration(milliseconds: 200),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20.w, bottom: 15.h),
                          child: Text(
                            lang.pleaseFillTheCredentials,
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      FadeInRight(
                        delay: const Duration(milliseconds: 550),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: TextFormFieldBuilder(
                            height: 80.h,
                            label: lang.email,
                            controller: cubit.emailController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return lang.enterEmailAddress;
                              }
                              if (!isValidEmail(value)) {
                                return lang.invalidEmailFormat;
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.sp),
                            obsecure: false,
                            type: TextInputType.emailAddress,
                            imagePath: 'assets/images/email 2.png',
                          ),
                        ),
                      ),
                      FadeInRight(
                        delay: const Duration(milliseconds: 600),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: TextFormFieldBuilder(
                            height: 80.h,
                            type: TextInputType.text,
                            obsecure: obscure2,
                            imagePath: "assets/images/padlock.png",
                            suffixIcon: InkWell(
                              onTap: () => setState(() => obscure2 = !obscure2),
                              child: Icon(
                                obscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            controller: cubit.passwordController,
                            label: lang.password,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return lang.enterPassword;
                              }
                              if (!isValidPassword(text)) {
                                return lang.password_validation;
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      ),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 700),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: 20.w, bottom: 15.h, top: 12.h),
                          child: GestureDetector(
                            onTap: () {
                              navigateTo(
                                  context: context, screen: ForgotPassword());
                            },
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                lang.forgotPassword,
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontSize: 14.sp),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 750),
                        child: ButtonBuilder(
                          text: lang.sign_in,
                          onTap: () =>
                              SignInLogic.handleLoginButtonTap(context, cubit),
                          width: 220.w,
                          height: 55.h,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                child: Text(lang.or,
                                    style: theme.textTheme.titleMedium),
                              ),
                              Expanded(
                                child: Divider(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 850),
                        child: Padding(
                          padding: EdgeInsets.all(16.0.sp),
                          child: SignInPart(
                            onTap: () {
                              // cubit.loginWithFacebook();
                            },
                            title: lang.continue_with_facebook,
                            imagePath: "assets/images/f_c.png",
                          ),
                        ),
                      ),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 900),
                        child: Padding(
                          padding: EdgeInsets.all(16.0.sp),
                          child: SignInPart(
                            onTap: () => cubit.signInWithGoogle(),
                            title: lang.continue_with_google,
                            imagePath: "assets/images/mdi_google.png",
                          ),
                        ),
                      ),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 950),
                        child: Padding(
                          padding: EdgeInsets.all(16.0.sp),
                          child: SignInPart(
                            onTap: () => SignInLogic.loginAsGuest(context),
                            title: lang.continue_as_guest,
                            imagePath: "assets/images/Vector.png",
                          ),
                        ),
                      ),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 1000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang.no_account,
                              style: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 17.sp),
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () {
                                cubit.emailController.clear();
                                cubit.passwordController.clear();
                                navigateAndReplace(
                                  context: context,
                                  screen: const SignUp(),
                                );
                              },
                              child: Text(
                                lang.sign_up,
                                style: theme.textTheme.labelLarge!
                                    .copyWith(fontSize: 17.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                );
              },
            ),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const AbsorbPointer(
                  absorbing: true,
                  child: LoadingIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
