import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/widgets/payment_info_part/payment_text.dart';
import '../../../../../widgets/button/button_builder.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentTextKey = GlobalKey<PaymentTextState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: Container(
              width: 959.95.w,
              height: 668.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bank info",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 7.sp,
                      ),
                    ),
                    Text(
                      "Update your Bank info",
                      style: TextStyle(
                        color: const Color(0xFF625C5C),
                        fontSize: 3.sp,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PaymentText(key: paymentTextKey),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 60.w),
                      child: ButtonBuilder(
                        text: 'Save',
                        onTap: () {
                          if (paymentTextKey.currentState?.validateFields() ??
                              false) {
                            paymentTextKey.currentState
                                ?.savePaymentDetails(); // ✅ حفظ البيانات
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    '⚠️ Please fill all fields or fix errors!'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        width: 45.w,
                        height: 60.h,
                        buttonColor: const Color(0xFF560B76),
                        frameColor: const Color(0xFF560B76),
                        borderShape: BorderRadius.circular(15.r),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
