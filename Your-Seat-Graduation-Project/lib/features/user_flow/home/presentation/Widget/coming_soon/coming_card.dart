// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// //
// // class ComingCard extends StatelessWidget {
// //   final String title;
// //   final String genre;
// //   final String date;
// //   final String imageUrl;
// //
// //    const ComingCard({super.key,
// //     required this.title,
// //     required this.genre,
// //     required this.date,
// //     required this.imageUrl,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(10.0),
// //       child: SizedBox(
// //         width: 160.sp,
// //         height: 300.sp,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(10),
// //               child: Image.asset(
// //                 imageUrl,
// //                 height: 240.sp,
// //                 width: 160.sp,
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //             SizedBox(height: 8.h),
// //             Text(
// //               title,
// //               style: TextStyle(
// //                 color: const Color(0xFFFCC434),
// //                 fontSize: 16.sp,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //               maxLines: 2,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             SizedBox(height: 4.h),
// //             Text(
// //               genre,
// //               style: TextStyle(
// //                 color: Colors.white70,
// //                 fontSize: 12.sp,
// //               ),
// //             ),
// //             SizedBox(height: 4.h),
// //             Text(
// //               date,
// //               style: TextStyle(
// //                 color: Colors.white70,
// //                 fontSize: 12.sp,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yourseatgraduationproject/widgets/network_image/image_replacer.dart';
//
// class ComingCard extends StatelessWidget {
//   final String title;
//   final String genre;
//   final String date;
//   final String imageUrl;
//
//   const ComingCard({
//     super.key,
//     required this.title,
//     required this.genre,
//     required this.date,
//     required this.imageUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: SizedBox(
//         width: 160.sp,
//         height: 300.sp,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Movie Poster
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: ImageReplacer(
//                 imageUrl: imageUrl,
//                 height: 240.sp,
//                 width: 160.sp,
//                 fit: BoxFit.cover,
//                 // loadingBuilder: (context, child, loadingProgress) {
//                 //   if (loadingProgress == null) return child;
//                 //   return Center(
//                 //     child: CircularProgressIndicator(
//                 //       value: loadingProgress.expectedTotalBytes != null
//                 //           ? loadingProgress.cumulativeBytesLoaded /
//                 //               loadingProgress.expectedTotalBytes!
//                 //           : null,
//                 //     ),
//                 //   );
//                 // },
//                 // errorBuilder: (context, error, stackTrace) {
//                 //   return Container(
//                 //     height: 240.sp,
//                 //     width: 160.sp,
//                 //     color: Colors.grey.shade800,
//                 //     child: const Icon(
//                 //       Icons.broken_image,
//                 //       color: Colors.white,
//                 //       size: 50,
//                 //     ),
//                 //   );
//                 // },
//               ),
//             ),
//             SizedBox(height: 8.h),
//
//             // Movie Title
//             Text(
//               title,
//               style: TextStyle(
//                 color: const Color(0xFFFCC434),
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(height: 4.h),
//
//             // Movie Genre
//             Text(
//               genre,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.onPrimary,
//                 fontSize: 12.sp,
//               ),
//             ),
//             SizedBox(height: 4.h),
//
//             // Movie Release Date
//             Text(
//               date,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.onPrimary,
//                 fontSize: 12.sp,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/widgets/network_image/image_replacer.dart';

class ComingCard extends StatelessWidget {
  final String title;
  final String genre;
  final String date;
  final String imageUrl;

  const ComingCard({
    super.key,
    required this.title,
    required this.genre,
    required this.date,
    required this.imageUrl,
  });

  // دالة للتحقق إذا كانت الصورة بصيغة Base64
  bool isBase64(String imageUrl) {
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/=]+$');
    return base64Pattern.hasMatch(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 160.sp,
        height: 300.sp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تحقق من نوع الصورة إذا كانت Base64 أو URL
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: isBase64(imageUrl)
                  ? Image.memory(
                      base64Decode(imageUrl), // تحويل Base64 إلى صورة
                      height: 240.sp,
                      width: 160.sp,
                      fit: BoxFit.cover,
                    )
                  : ImageReplacer(
                      imageUrl:
                          imageUrl, // استخدام ImageReplacer إذا كانت صورة URL
                      height: 240.sp,
                      width: 160.sp,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 8.h),

            // عنوان الفيلم
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFFFCC434),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),

            // نوع الفيلم
            Text(
              genre,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),

            // تاريخ عرض الفيلم
            Text(
              date,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
