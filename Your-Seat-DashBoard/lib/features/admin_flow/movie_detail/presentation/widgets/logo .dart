// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yourseatgraduationproject/widgets/text_field/text_field/new_text_field_builder.dart';
// import '../../../../../widgets/button/button_builder.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
//
// class logo extends StatelessWidget {
//   final PlatformFile? pickedCover;
//   final Function(PlatformFile?) onPick;
//   final VoidCallback onDelete;
//   final Color errorColor;
//   final bool isViewOnly;
//
//   const logo({
//     super.key,
//     required this.pickedCover,
//     required this.onPick,
//     required this.onDelete,
//     required this.errorColor,
//     this.isViewOnly = false,
//   });
//
//   Future<void> pickCover(BuildContext context) async {
//     if (isViewOnly) return;
//
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       withData: true,
//     );
//
//     if (result != null && result.files.single.bytes != null) {
//       context.read<MovieCubit>().pickedCover = result.files.single;
//       onPick(result.files.single);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Film Logo Label
//         Padding(
//           padding: EdgeInsets.only(right: 35.w),
//           child: Text(
//             "Film Logo",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 5.sp,
//             ),
//           ),
//         ),
//         SizedBox(height: 5.h),
//
//         // Logo Image
//         Container(
//           width: 60.w,
//           height: 130.h,
//           color: Colors.grey[300],
//           child: pickedCover != null
//               ? Image.memory(pickedCover!.bytes!, fit: BoxFit.cover)
//               : Image.asset("assets/images/avatar_film.png", fit: BoxFit.cover),
//         ),
//         SizedBox(height: 25.h),
//
//         // Upload & Delete buttons
//         if (!isViewOnly) ...[
//           Row(
//             children: [
//               SizedBox(width: 15.w),
//               ButtonBuilder(
//                 text: pickedCover == null ? 'Upload' : 'Change',
//                 onTap: () => pickCover(context),
//                 width: 30.w,
//                 height: 51.h,
//                 buttonColor: const Color(0xFF560B76),
//                 frameColor: const Color(0xFF560B76),
//                 borderShape: BorderRadius.circular(15.r),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 6.sp,
//                 ),
//               ),
//               SizedBox(width: 2.w),
//               ButtonBuilder(
//                 text: 'Delete',
//                 onTap: onDelete,
//                 width: 30.w,
//                 height: 51.h,
//                 buttonColor: const Color(0xFFFF0000),
//                 frameColor: const Color(0xFFFF0000),
//                 borderShape: BorderRadius.circular(15.r),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 6.sp,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15.h),
//         ],
//       ],
//     );
//   }
// }


import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/button/button_builder.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';

class Logo extends StatefulWidget {
  final PlatformFile? pickedCover;
  final Function(PlatformFile?) onPick;
  final VoidCallback onDelete;
  final Color errorColor;
  final bool isViewOnly;
  final String? base64Image;
  final bool readOnly;
  const Logo({
    super.key,
    required this.pickedCover,
    required this.onPick,
    required this.onDelete,
    required this.errorColor,
    this.isViewOnly = false,
    this.readOnly = false,
    this.base64Image, Uint8List? imageBytes,
  });

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  Future<void> pickCover(BuildContext context) async {
    if (widget.isViewOnly) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      context.read<MovieCubit>().pickedCover = result.files.single;
      widget.onPick(result.files.single);
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;

    if (widget.pickedCover != null && widget.pickedCover!.bytes != null) {
      imageBytes = widget.pickedCover!.bytes!;
    } else if (widget.base64Image != null && widget.base64Image!.isNotEmpty) {
      try {
        imageBytes = base64Decode(widget.base64Image!);
      } catch (_) {
        imageBytes = null;
      }
    }
    MovieCubit.get(context).pickedCover = widget.pickedCover;

    return Column(
      children: [
        // Film Logo Label
        Padding(
          padding: EdgeInsets.only(right: 35.w),
          child: Text(
            "Film Logo",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 5.sp,
            ),
          ),
        ),
        SizedBox(height: 5.h),

        // Logo Image
        Container(
          width: 60.w,
          height: 130.h,
          color: Colors.grey[300],
          child: imageBytes != null
              ? Image.memory(imageBytes, fit: BoxFit.cover)
              : Image.asset("assets/images/avatar_film.png", fit: BoxFit.cover),
        ),
        SizedBox(height: 25.h),

        // Upload & Delete buttons
        if (!widget.isViewOnly && !widget.readOnly) ...[
          Row(
            children: [
              SizedBox(width: 3.w),
              ButtonBuilder(
                text: widget.pickedCover == null ? 'Upload' : 'Change',
                onTap: () => pickCover(context),
                width: 30.w,
                height: 51.h,
                buttonColor: const Color(0xFF560B76),
                frameColor: const Color(0xFF560B76),
                borderShape: BorderRadius.circular(15.r),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 6.sp,
                ),
              ),
              SizedBox(width: 2.w),
              ButtonBuilder(
                text: 'Delete',
                onTap: widget.onDelete,
                width: 30.w,
                height: 51.h,
                buttonColor: const Color(0xFFFF0000),
                frameColor: const Color(0xFFFF0000),
                borderShape: BorderRadius.circular(15.r),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 6.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ],
    );
  }
}

