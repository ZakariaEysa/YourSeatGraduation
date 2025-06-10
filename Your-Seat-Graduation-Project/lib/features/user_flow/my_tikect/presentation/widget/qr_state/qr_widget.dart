// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import '../../../about_us/presentation/views/about_us.dart';
//
// class QrState extends StatelessWidget {
//    QrState({super.key});
//   Map<String,dynamic> ahmed = {
//     "ahmed" : "1235",
//     "cinema" : "Plaza",
//     "movie" : "Avengers"
//     };
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding:  EdgeInsetsDirectional.fromSTEB(0, 560.h, 0, 0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Padding(
//             padding: EdgeInsetsDirectional.only(bottom: 70.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 QrImageView(
//                     data: ahmed.toString(),
//                     size: 120.sp,
//                     backgroundColor: Colors.white,
//                   ),
//                 Column(
//                   children: [
//                     Text(
//                       "Payment : paymed",
//                       style: TextStyle(color: Colors.black, fontSize: 14.sp),
//                     ),
//                     SizedBox(height: 5.h),
//                     Text(
//                       "Status    :      Active",
//                       style: TextStyle(color: Colors.black, fontSize: 14.sp),
//                     ),
//                     SizedBox(height: 7.h),
//                     Row(
//                       children: [
//                         Text(
//                           "Download ticket",
//                           style: TextStyle(color: Colors.black, fontSize: 14.sp),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             print('Image clicked!');
//                           },
//                           child: Padding(
//                             padding: EdgeInsetsDirectional.only(start: 5.w),
//                             child: Image.asset(
//                               "assets/icons/img_4.png",
//                               width: 15.w,
//                               height: 15.h,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../generated/l10n.dart';

class QrWidget extends StatelessWidget {
  String? movieName;
  String? movieDuration;
  String? movieCategory;
  String? seatCategory;
  String? movieTime;
  String? movieDate;
  List<String>? seats;
  String? hall;
  String orderId;
  String? cost;
  String? cinemaId;
  String? location;
  String status;
  QrWidget(
      {super.key,
      required this.movieName,
      required this.movieDuration,
      required this.movieCategory,
      required this.seatCategory,
      required this.movieTime,
      required this.movieDate,
      required this.seats,
      required this.hall,
      required this.cost,
      required this.status,
      required this.location,
      required this.cinemaId,
      required this.orderId});

  Future<String> getDownloadPath() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory(
          '/storage/emulated/0/Download'); // مجلد التنزيلات في أندرويد
    } else {
      directory =
          await getApplicationDocumentsDirectory(); // المسار الافتراضي في iOS
    }
    return directory.path;
  }

  Future<void> generateAndSavePDF(BuildContext context) async {
    final pdf = pw.Document();

    // إنشاء QR Code كصورة
    final qrImage = await QrPainter(
      data: orderId,
      version: QrVersions.auto,
      gapless: false,
    ).toImage(200);

    final ByteData? byteData =
        await qrImage.toByteData(format: ImageByteFormat.png);
    final Uint8List qrBytes = byteData!.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(16.sp),
            decoration: pw.BoxDecoration(
              //color: PdfColor.fromHex("#1E0460"),
              borderRadius: pw.BorderRadius.circular(10.r),
              border: pw.Border.all(color: PdfColors.black, width: 2.w),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 10.h),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(movieName ?? "",
                          style: pw.TextStyle(
                            fontSize: 25.sp,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.Image(pw.MemoryImage(qrBytes),
                          width: 150.w, height: 120.h),
                    ]),
                pw.SizedBox(height: 15.h),
                pw.Text("Duration: ${movieDuration ?? ""}",
                    style: pw.TextStyle(fontSize: 14.sp)),
                pw.Text("Category: ${movieCategory ?? ""}",
                    style: pw.TextStyle(fontSize: 14.sp)),
                pw.SizedBox(height: 10.h),
                pw.Text("Price: ${cost ?? ""} EGP",
                    style: pw.TextStyle(fontSize: 14.sp)),
                pw.Text("Cinema: ${cinemaId ?? ""}",
                    style: pw.TextStyle(fontSize: 14.sp)),
                pw.Text("Location: ${location ?? ""}",
                    style: pw.TextStyle(fontSize: 14.sp)),
                pw.SizedBox(height: 10.h),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Time: ${movieTime ?? ""}",
                        style: pw.TextStyle(fontSize: 14.sp)),
                    pw.Text("Date: ${movieDate ?? ""}",
                        style: pw.TextStyle(fontSize: 14.sp)),
                    pw.Text("Seat: ${seats ?? ""}",
                        style: pw.TextStyle(fontSize: 14.sp)),
                    pw.Text("Hall: ${hall ?? ""}",
                        style: pw.TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    final downloadPath = await getDownloadPath();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File("$downloadPath/YourSeat_Ticket_$timestamp.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("📄 Your Ticket saved in ${file.path}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 560.h, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 70.h, end: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                QrImageView(
                  data: orderId,
                  size: 120.sp,
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30.w, left: 30.w),
                  child: Column(
                    children: [
                      Text(
                        "Payment : Paid",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Status : ${status ?? ""}",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Text(
                            lang.downloadTicket,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          InkWell(
                            onTap: () => generateAndSavePDF(context),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 5.w),
                              child: Image.asset(
                                "assets/icons/img_4.png",
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
