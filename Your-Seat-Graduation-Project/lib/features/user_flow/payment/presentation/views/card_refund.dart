// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../about_us/presentation/views/about_us.dart';
// import '../widgets/card_part.dart';
// import 'payment_refund.dart';
// import 'refund_successful.dart';

// import '../../../../../data/hive_keys.dart';
// import '../../../../../data/hive_stroage.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../../../utils/navigation.dart';
// import '../../../../../widgets/button/button_builder.dart';
// import '../../../../../widgets/scaffold/scaffold_f.dart';
// import '../../../../../widgets/text_field/text_field/text_form_field_builder.dart';
// import '../../../auth/presentation/views/otp.dart';

// class CardRefund extends StatefulWidget {
//   const CardRefund({super.key});

//   @override
//   State<CardRefund> createState() => _CarrdState();
// }

// class _CarrdState extends State<CardRefund> {
//   @override
//   Widget build(BuildContext context) {
//     var lang = S.of(context);
//     final theme = Theme.of(context);
//     return ScaffoldF(
//         appBar: AppBar(
//           title: Text(
//             lang.cardInformation,
//             style: theme.textTheme.labelLarge!.copyWith(fontSize: 23.sp),
//           ),
//           titleSpacing: 40.0,
//           backgroundColor: const Color(0xFF2E1371),
//           leading: IconButton(
//               onPressed: () {
//                 navigateTo(context: context, screen: PaymentRefund());
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//                 size: 30.sp,
//               )),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//               padding: EdgeInsets.only(left: 30.w, top: 50.h, right: 20.w),
//               child: Column(children: [
//                 CardPart(),
//                 SizedBox(
//                   height: 80.h,
//                 ),
//                 ButtonBuilder(
//                   width: 287.w,
//                   height: 58.h,
//                   text: 'Complete Your Purchase',
//                   buttonColor: Color(0xFFF2F2F2).withOpacity(.29),
//                   frameColor: Color(0xFFFF89F3),
//                   style: theme.textTheme.titleMedium!.copyWith(
//                     fontSize: 16.sp,
//                   ),
//                   onTap: () {
//                     navigateTo(context: context, screen: RefundSuccessful());
//                   },
//                 ),
//               ])),
//         ));
//   }
// }
