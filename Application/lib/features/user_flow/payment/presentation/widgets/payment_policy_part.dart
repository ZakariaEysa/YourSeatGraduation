import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';

class PaymentPolicyPart extends StatefulWidget {
  const PaymentPolicyPart({super.key});

  @override
  State<PaymentPolicyPart> createState() => _PaymentPolicyPartState();
}

class _PaymentPolicyPartState extends State<PaymentPolicyPart> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        width: 350.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xFF2F1472).withOpacity(.69),
            border: Border.all(color: Color(0xFF815AE2), width: 1.w)),
        padding: EdgeInsets.all(16.sp),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                lang.currency,
                style: theme.textTheme.labelLarge!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                lang.allTransactionsOnYourSeatWillBeProcessedInLocalCurrency,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              Text(
                lang.paymentTiming,
                style: theme.textTheme.labelLarge!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                lang.paymentsMustBeCompletedAtTheTimeOfBookingYourBookingWillOnlyBeConfirmedUponSuccessfulPaymentPartialPaymentsAreNotAcceptedFullPaymentIsRequiredForTicketConfirmation,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              Text(
                lang.bookingConfirmation,
                style: theme.textTheme.labelLarge!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                lang.oncePaymentIsSuccessfulAConfirmationEmailWithTicketDetailsAndBookingInformationWillBeSentToTheRegisteredEmailAddressIfYouDoNotReceiveAConfirmationWithinThirtyMinutesOfPaymentPleaseContactOurSupportTeamAtSupportYourSeatCom,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                lang.cancellationsRefunds,
                style: theme.textTheme.labelLarge!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                lang.ifCanceledMoreThanTwelveHoursBeforeTheMovie_sStartTimeTheCustomerIsEligibleForAFullRefundIfCanceledWithinTwelveHoursButMoreThanThirtyMinutesBeforeTheMovie_sStartTimeTheCustomerWillReceiveFiftyOutOfAHundredOfTheTicketAmountAsARefundCancellationsMadeLessThanThirtyMinutesBeforeTheMovie_sStartTimeAreNonRefundableRefundProcessInEligibleCasesRefundsWillBeCreditedBackToTheOriginalPaymentMethodWithinFive_TenBusinessDaysBankProcessingTimesMayVary,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              Text(
                lang.serviceFees,
                style: theme.textTheme.labelLarge!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                lang.anyServiceOrProcessingFeesAssociatedWithTheBookingAreNonRefundable,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: Color(0xFF9B51E0),
                      checkColor: Colors.black,
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                  Text(lang.iAgreeWithPrivacyPolicy,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ]),
      ),
    );
  }
}
