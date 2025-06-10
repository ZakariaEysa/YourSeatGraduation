import 'package:email_otp_auth/email_otp_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../../../home/presentation/views/home_layout.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/otp_textfield.dart';
import '../widgets/timer.dart';

class Otp extends StatefulWidget {
  final Future<void> Function()? isSuccessOtp;
  const Otp({super.key, this.isSuccessOtp});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();

  Future<void> verifyOtp(BuildContext context, String otp) async {
    bool isOtpValid =
        (await EmailOtpAuth.verifyOtp(otp: otp))["message"] == "OTP Verified";
    if (isOtpValid) {
      if (widget.isSuccessOtp == null) {
        await AuthCubit.get(context).verifyedSendOtp();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeLayout()),
        );
      } else {
        await widget.isSuccessOtp!();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void nextField({
    required String value,
    required FocusNode focusNode,
  }) {
    if (value.isNotEmpty) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return ScaffoldF(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 28),
        title: Text(
          lang.ConfirmOTPcode,
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Text(
            lang.PleaseEnterThe6DigitCodeSentToYourEmail,
            style: theme.textTheme.bodySmall!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpFieldWidget(
                  controller: otpController1,
                  currentFocus: focusNode1,
                  nextFocus: focusNode2,
                  previousFocus: null,
                  nextField: nextField,
                  autofocus: true,
                ),
                OtpFieldWidget(
                  controller: otpController2,
                  currentFocus: focusNode2,
                  nextFocus: focusNode3,
                  previousFocus: focusNode1,
                  nextField: nextField,
                ),
                OtpFieldWidget(
                  controller: otpController3,
                  currentFocus: focusNode3,
                  nextFocus: focusNode4,
                  previousFocus: focusNode2,
                  nextField: nextField,
                ),
                OtpFieldWidget(
                  controller: otpController4,
                  currentFocus: focusNode4,
                  nextFocus: focusNode5,
                  previousFocus: focusNode3,
                  nextField: nextField,
                ),
                OtpFieldWidget(
                  controller: otpController5,
                  currentFocus: focusNode5,
                  nextFocus: focusNode6,
                  previousFocus: focusNode4,
                  nextField: nextField,
                ),
                OtpFieldWidget(
                  controller: otpController6,
                  currentFocus: focusNode6,
                  nextFocus: null,
                  previousFocus: focusNode5,
                  nextField: nextField,
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CountdownTimer(
                  onResend: () async {
                    String email = AuthCubit.get(context).emailController.text;
                    if (email.isNotEmpty) {
                      AuthCubit.get(context).sendOtp(email);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "OTP has been resent",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          ButtonBuilder(
            text: 'Continue',
            onTap: () {
              if (otpController1.text.isEmpty ||
                  otpController2.text.isEmpty ||
                  otpController3.text.isEmpty ||
                  otpController4.text.isEmpty ||
                  otpController5.text.isEmpty ||
                  otpController6.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter all numbers OTP'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                String otp = otpController1.text +
                    otpController2.text +
                    otpController3.text +
                    otpController4.text +
                    otpController5.text +
                    otpController6.text;
                // print("OTP entered: $otp"); // Removed: was used for debugging OTP entry
                verifyOtp(context, otp);
              }
            },
          )
        ],
      ),
    );
  }
}
