// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:yourseatgraduationproject/features/user_flow/my_tikect/presentation/widget/qr_state/qr_state.dart';
//
// class QrCubit extends Cubit<QrState> {
//   QrCubit({
//     required String orderId,
//     required String movieName,
//     required String movieDuration,
//     required String movieCategory,
//     required String seatCategory,
//     required String movieTime,
//     required String movieDate,
//     required List<String> seats,
//     required String hall,
//     required String cost,
//     required String cinemaId,
//     required String location,
//     required String status,
//   }) : super(QrState(
//     orderId: orderId,
//     movieName: movieName,
//     movieDuration: movieDuration,
//     movieCategory: movieCategory,
//     seatCategory: seatCategory,
//     movieTime: movieTime,
//     movieDate: movieDate,
//     seats: seats,
//     hall: hall,
//     cost: cost,
//     cinemaId: cinemaId,
//     location: location,
//     status: status,
//   ));
//
//   Future<void> generateAndSavePDF() async {
//     try {
//       emit(state.copyWith(isLoading: true));
//
//       final pdf = pw.Document();
//
//       final qrImage = await QrPainter(
//         data: state.orderId,
//         version: QrVersions.auto,
//         gapless: false,
//       ).toImage(200);
//
//       final ByteData? byteData = await qrImage.toByteData(format: ImageByteFormat.png);
//       final Uint8List qrBytes = byteData!.buffer.asUint8List();
//
//       pdf.addPage(
//         pw.Page(
//           build: (pw.Context context) {
//             return pw.Container(
//               padding: pw.EdgeInsets.all(16),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(color: PdfColors.black, width: 2),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(state.movieName, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold)),
//                   pw.Image(pw.MemoryImage(qrBytes), width: 150, height: 120),
//                   pw.SizedBox(height: 15),
//                   pw.Text("Duration: ${state.movieDuration}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Category: ${state.movieCategory}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Price: ${state.cost} EGP", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Cinema: ${state.cinemaId}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Location: ${state.location}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Time: ${state.movieTime}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Date: ${state.movieDate}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Seat: ${state.seats.join(", ")}", style: pw.TextStyle(fontSize: 14)),
//                   pw.Text("Hall: ${state.hall}", style: pw.TextStyle(fontSize: 14)),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//
//       final directory = Platform.isAndroid
//           ? Directory('/storage/emulated/0/Download')
//           : await getApplicationDocumentsDirectory();
//
//       final timestamp = DateTime.now().millisecondsSinceEpoch;
//       final file = File("${directory.path}/YourSeat_Ticket_$timestamp.pdf");
//       await file.writeAsBytes(await pdf.save());
//
//       emit(state.copyWith(isLoading: false, filePath: file.path));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, errorMessage: "Failed to save ticket: $e"));
//     }
//   }
// }
