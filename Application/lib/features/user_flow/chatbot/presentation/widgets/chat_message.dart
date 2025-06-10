// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../generated/l10n.dart';
//
// class ChatMessage extends StatelessWidget {
//   const ChatMessage({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     var lang = S.of(context);
//     final theme = Theme.of(context);
//     return Padding(
//       padding: EdgeInsets.only(right: 150.w, top: 40.h, left: 20.w),
//       child: Container(
//           width: 300.w,
//           height: 50.h,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               gradient: const LinearGradient(
//                 colors: [
//                   Color(0xFF802886),
//                   Color(0xFF3E1B95),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               border: Border.all(color: Colors.white)),
//           child: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(15, 5, 5, 5),
//             child: Text(
//               lang.canyouhelp,
//               style: theme.textTheme.labelSmall!
//                   .copyWith(fontSize: 24.sp, color: Colors.white),
//             ),
//           )),
//     );
//   }
// }
