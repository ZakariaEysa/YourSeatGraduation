// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'payment_refund.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../../../utils/navigation.dart';
// import '../../../../../widgets/button/button_builder.dart';
// import '../../../../../widgets/scaffold/scaffold_f.dart';
// import 'payment.dart';
// import '../widgets/payment_policy_part.dart';

// class PaymentPolicyRefund extends StatefulWidget {
//   const PaymentPolicyRefund({super.key});

//   @override
//   State<PaymentPolicyRefund> createState() => _PaymentPolicyRefundState();
// }

// class _PaymentPolicyRefundState extends State<PaymentPolicyRefund> {
//   @override
//   Widget build(BuildContext context) {
//     var lang = S.of(context);
//     final theme = Theme.of(context);
//     return ScaffoldF(
//       appBar: AppBar(
//         title: Text(
//           lang.paymentPolicy,
//           style: theme.textTheme.labelLarge!.copyWith(fontSize: 23.sp),
//         ),
//         titleSpacing: 40.0,
//         backgroundColor: const Color(0xFF2E1371),
//         leading: IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//               size: 25.sp,
//             )),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10.h,
//             ),
//             PaymentPolicyPart(),
//             SizedBox(
//               height: 30.h,
//             ),
//             ButtonBuilder(
//               text: lang.continnue,
//               onTap: () {
//                 navigateTo(context: context, screen: PaymentRefund());
//               },
//             ),
//             SizedBox(
//               height: 50.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
