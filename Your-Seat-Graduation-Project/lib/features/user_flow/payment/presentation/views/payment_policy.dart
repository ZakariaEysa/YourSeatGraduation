import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/dialog_utilits.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../data/remote_data_source/payment_remote_data_source.dart';
import '../../data/repos_impl/payment_repo_impl.dart';
import '../cubit/payment_cubit.dart';
import 'payment.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/button/button_builder.dart';

class PaymentPolicy extends StatefulWidget {
  const PaymentPolicy(
      {super.key,
      required this.model,
      required this.seatCategory,
      required this.seats,
      required this.price,
      required this.location,
      required this.date,
      required this.time,
      required this.cinemaId,
      required this.hall});
  final MoviesDetailsModel model;
  final String seatCategory;
  final List<String> seats;
  final num price;
  final String location;
  final String date;
  final String time;
  final String hall;
  final String cinemaId;

  @override
  State<PaymentPolicy> createState() => _PaymentPolicyState();
}

class _PaymentPolicyState extends State<PaymentPolicy> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // AppLogs.successLog(widget.seatCategory.toString()); // Removed: was used for logging seat category
    // AppLogs.successLog(widget.hall.toString()); // Removed: was used for logging hall
    // AppLogs.successLog(widget.cinemaId.toString()); // Removed: was used for logging cinemaId
    // AppLogs.successLog(widget.model.toString()); // Removed: was used for logging model
    // AppLogs.successLog(widget.price.toString()); // Removed: was used for logging price
    // AppLogs.successLog(widget.date.toString()); // Removed: was used for logging date
    // AppLogs.successLog(widget.time.toString()); // Removed: was used for logging time
    // AppLogs.successLog(widget.location.toString()); // Removed: was used for logging location
    // AppLogs.successLog(widget.seatCategory.toString()); // Removed: was used for logging seat category (duplicate)
    // AppLogs.successLog(widget.seats.toString()); // Removed: was used for logging seats

    var lang = S.of(context);
    final theme = Theme.of(context);
    return ScaffoldF(
      appBar: AppBar(
        title: Text(
          lang.paymentPolicy,
          style: theme.textTheme.labelLarge!.copyWith(fontSize: 23.sp),
        ),
        titleSpacing: 40.0,
        leading: IconButton(
            onPressed: () {
              navigatePop(context: context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 25.sp,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 350.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.69),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.sp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      lang.currency,
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      lang.allTransactionsOnYourSeatWillBeProcessedInLocalCurrency,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      lang.paymentTiming,
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      lang.paymentsMustBeCompletedAtTheTimeOfBookingYourBookingWillOnlyBeConfirmedUponSuccessfulPaymentPartialPaymentsAreNotAcceptedFullPaymentIsRequiredForTicketConfirmation,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      lang.bookingConfirmation,
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      lang.oncePaymentIsSuccessfulAConfirmationEmailWithTicketDetailsAndBookingInformationWillBeSentToTheRegisteredEmailAddressIfYouDoNotReceiveAConfirmationWithinThirtyMinutesOfPaymentPleaseContactOurSupportTeamAtSupportYourSeatCom,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      lang.cancellationsRefunds,
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      lang.ifCanceledMoreThanTwelveHoursBeforeTheMovie_sStartTimeTheCustomerIsEligibleForAFullRefundIfCanceledWithinTwelveHoursButMoreThanThirtyMinutesBeforeTheMovie_sStartTimeTheCustomerWillReceiveFiftyOutOfAHundredOfTheTicketAmountAsARefundCancellationsMadeLessThanThirtyMinutesBeforeTheMovie_sStartTimeAreNonRefundableRefundProcessInEligibleCasesRefundsWillBeCreditedBackToTheOriginalPaymentMethodWithinFive_TenBusinessDaysBankProcessingTimesMayVary,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      lang.serviceFees,
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      lang.anyServiceOrProcessingFeesAssociatedWithTheBookingAreNonRefundable,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
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
            SizedBox(
              height: 30.h,
            ),
            ButtonBuilder(
              text: lang.continuee,
              onTap: () {
                if (isChecked) {
                  navigateAndReplace(
                    context: context,
                    screen: BlocProvider(
                        create: (context) => PaymentCubit(
                            PaymentRepoImpl(PaymentRemoteDataSourceImpl())),
                        child: Payment(
                          hall: widget.hall,
                          model: widget.model,
                          seatCategory: widget.seatCategory,
                          seats: widget.seats,
                          price: widget.price,
                          location: widget.location,
                          date: widget.date,
                          time: widget.time,
                          cinemaId: widget.cinemaId,
                        )),
                  );
                } else {
                  showCenteredSnackBar(context, "pleaseAgreeWithPrivacyPolicy");
                }
              },
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
