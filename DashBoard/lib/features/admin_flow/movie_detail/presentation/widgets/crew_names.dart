// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
// import '../../../../../widgets/validators/Validators.dart';
//
// ///////////////////////////////////////////////////////////////////////////////////////////////////
// //-----------------------   class for director,writer and producer    ---------------------------//
// ///////////////////////////////////////////////////////////////////////////////////////////////////
//
// class CrewNames extends StatefulWidget {
//   const CrewNames({
//     super.key,
//     required this.directorName,
//     required this.writerName,
//     required this.producerName,
//     this.isViewOnly = false,
//   });
//
//   final String directorName;
//   final String writerName;
//   final String producerName;
//   final bool isViewOnly;
//
//   static final GlobalKey<_CrewNamesState> crewKey =
//       GlobalKey<_CrewNamesState>();
//
//   bool validate() {
//     return crewKey.currentState?._validateFields() ?? false;
//   }
//
//   @override
//   _CrewNamesState createState() => _CrewNamesState();
// }
//
// class _CrewNamesState extends State<CrewNames> {
//
//   Uint8List? _directorImage;
//   Uint8List? _writerImage;
//   Uint8List? _producerImage;
//   String? _directorError;
//   String? _writerError;
//   String? _producerError;
//
//   bool _validateFields() {
//     setState(() {
//       _directorError = Validators.validateRequired(
//         lettersOnly: true,
//           MovieCubit.get(context).directorController.text, 'Director Name');
//       _writerError =
//           Validators.validateRequired(        lettersOnly: true,
//               MovieCubit.get(context).writerController.text, 'Writer Name');
//       _producerError = Validators.validateRequired(        lettersOnly: true,
//
//           MovieCubit.get(context).producerController.text, 'Producer Name');
//     });
//     return _directorError == null &&
//         _writerError == null &&
//         _producerError == null;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // _directorController = TextEditingController(text: widget.directorName);
//     // _writerController = TextEditingController(text: widget.writerName);
//     // _producerController = TextEditingController(text: widget.producerName);
//   }
//
//   @override
//   void dispose() {
//     // _directorController.dispose();
//     // _writerController.dispose();
//     // _producerController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImage(Function(Uint8List?) setImage) async {
//     if (widget.isViewOnly) return;
//     final cubit = MovieCubit.get(context);
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       final bytes = await picked.readAsBytes();
//       setState(() => setImage(bytes));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25.h),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         padding: EdgeInsets.all(7.sp),
//         child: Row(
//           children: [
//             // Director
//             SizedBox(
//               width: 100.w,
//               child: PersonNameField(
//                 label: 'Director Name',
//                 imageBytes: _directorImage,
//                 controller: MovieCubit.get(context).directorController,
//                 errorText: _directorError,
//                 validator: (value) =>
//                     Validators.validateRequired(value, 'Director Name',  lettersOnly: true,
//                       maxLength: 50,),
//                 onUpload: () =>
//                     _pickImage((img) => setState(() => _directorImage = img)),
//                 onDeleteImage: () => setState(() => _directorImage = null),
//                 isViewOnly: widget.isViewOnly,
//               ),
//             ),
//             SizedBox(
//               width: 6.w,
//             ),
//             // Writer
//             SizedBox(
//               width: 100.w,
//               child: PersonNameField(
//                 label: 'Writer Name',
//                 imageBytes: _writerImage,
//                 controller: MovieCubit.get(context).writerController,
//                 errorText: _writerError,
//                 validator: (value) =>
//                     Validators.validateRequired(value, 'Writer Name',  lettersOnly: true,
//                       maxLength: 50,),
//                 onUpload: () =>
//                     _pickImage((img) => setState(() => _writerImage = img)),
//                 onDeleteImage: () => setState(() => _writerImage = null),
//                 isViewOnly: widget.isViewOnly,
//               ),
//             ),
//             //   SizedBox(width: 3.w),
//             SizedBox(
//               width: 6.w,
//             ),
//
//             // Producer
//             SizedBox(
//               width: 100.w,
//               child: PersonNameField(
//                 label: 'Producer Name',
//                 imageBytes: _producerImage,
//                 controller: MovieCubit.get(context).producerController,
//                 errorText: _producerError,
//                 validator: (value) =>
//                     Validators.validateRequired(value, 'Producer Name',  lettersOnly: true,
//                       maxLength: 50,),
//                 onUpload: () =>
//                     _pickImage((img) => setState(() => _producerImage = img)),
//                 onDeleteImage: () => setState(() => _producerImage = null),
//                 isViewOnly: widget.isViewOnly,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
// import '../../../../../widgets/validators/Validators.dart';
//
// class CrewNames extends StatefulWidget {
//   const CrewNames({
//     super.key,
//     required this.movieData,
//     this.initialValue,
//     required this.directorName,
//     required this.writerName,
//     required this.producerName,
//     this.isViewOnly = false,
//   });
//   final String? initialValue;
//   final String directorName;
//   final String writerName;
//   final String producerName;
//   final bool isViewOnly;
//   final Map<String, dynamic> movieData;
//
//
//   static final GlobalKey<_CrewNamesState> crewKey = GlobalKey<_CrewNamesState>();
//
//   bool validate() {
//     return crewKey.currentState?._validateFields() ?? false;
//   }
//
//   @override
//   _CrewNamesState createState() => _CrewNamesState();
// }
//
// class _CrewNamesState extends State<CrewNames> {
//   Uint8List? _directorImage;
//   Uint8List? _writerImage;
//   Uint8List? _producerImage;
//   String? _directorError;
//   String? _writerError;
//   String? _producerError;
//
//   bool _validateFields() {
//     setState(() {
//       _directorError = Validators.validateRequired(
//         lettersOnly: true,
//         MovieCubit.get(context).directorController.text,
//         'Director Name',
//       );
//       _writerError = Validators.validateRequired(
//         lettersOnly: true,
//         MovieCubit.get(context).writerController.text,
//         'Writer Name',
//       );
//       _producerError = Validators.validateRequired(
//         lettersOnly: true,
//         MovieCubit.get(context).producerController.text,
//         'Producer Name',
//       );
//     });
//     return _directorError == null && _writerError == null && _producerError == null;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     var cubit = MovieCubit.get(context);
//
//     cubit.directorController.text = widget.directorName;
//     cubit.writerController.text = widget.writerName;
//     cubit.producerController.text = widget.producerName;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Future<void> _pickImage({
//     required Function(Uint8List?) setImage,
//     required Function(PlatformFile?) saveToCubit,
//   }) async {
//     if (widget.isViewOnly) return;
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       final bytes = await picked.readAsBytes();
//       final platformFile = PlatformFile(
//         name: picked.name,
//         size: bytes.length,
//         bytes: bytes,
//       );
//
//       setState(() {
//         setImage(bytes);
//       });
//       saveToCubit(platformFile);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = MovieCubit.get(context);
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25.h),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         padding: EdgeInsets.all(7.sp),
//         child: Row(
//           children: [
//             // Director
//             SizedBox(
//               width: 100.w,
//               child: PersonNameField(
//                 //initialValue:widget.isViewOnly? widget.directorName,
//                 label: 'Director Name',
//                 imageBytes: _directorImage,
//                 controller: cubit.directorController,
//                 errorText: _directorError,
//                 validator: (value) => Validators.validateRequired(
//                   value,
//                   'Director Name',
//                   lettersOnly: true,
//                   maxLength: 50,
//                 ),
//                 onUpload: () => _pickImage(
//                   setImage: (img) => _directorImage = img,
//                   saveToCubit: (file) => cubit.pickedDirectorImages = [file],
//                 ),
//                 onDeleteImage: () {
//                   setState(() => _directorImage = null);
//                   cubit.pickedDirectorImages.clear();
//                 },
//                 isViewOnly: widget.isViewOnly,
//               ),
//             ),
//             SizedBox(width: 6.w),
//
//             // Writer
//             SizedBox(
//               width: 100.w,
//               child: PersonNameField(
//                // initialValue: widget.writerName,
//                 label: 'Writer Name',
//                 imageBytes: _writerImage,
//                 controller: cubit.writerController,
//                 errorText: _writerError,
//                 validator: (value) => Validators.validateRequired(
//                   value,
//                   'Writer Name',
//                   lettersOnly: true,
//                   maxLength: 50,
//                 ),
//                 onUpload: () => _pickImage(
//                   setImage: (img) => _writerImage = img,
//                   saveToCubit: (file) => cubit.pickedWriterImages = [file],
//                 ),
//                 onDeleteImage: () {
//                   setState(() => _writerImage = null);
//                   cubit.pickedWriterImages.clear();
//                 },
//                 isViewOnly: widget.isViewOnly,
//               ),
//             ),
//             SizedBox(width: 6.w),
//
//             // Producer
//             SizedBox(
//               width: 100.w,
//               child: PersonNameField(
//                // initialValue: widget.producerName,
//                 label: 'Producer Name',
//                 imageBytes: _producerImage,
//                 controller: cubit.producerController,
//                 errorText: _producerError,
//                 validator: (value) => Validators.validateRequired(
//                   value,
//                   'Producer Name',
//                   lettersOnly: true,
//                   maxLength: 50,
//                 ),
//                 onUpload: () => _pickImage(
//                   setImage: (img) => _producerImage = img,
//                   saveToCubit: (file) => cubit.pickedProducerImages = [file],
//                 ),
//                 onDeleteImage: () {
//                   setState(() => _producerImage = null);
//                   cubit.pickedProducerImages.clear();
//                 },
//                 isViewOnly: widget.isViewOnly,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
import '../../../../../widgets/validators/Validators.dart';

class CrewNames extends StatefulWidget {
  const CrewNames({
    super.key,
    required this.movieData,
    this.initialValue,
    required this.directorName,
    required this.writerName,
    required this.producerName,
    this.isViewOnly = false,
  });

  final String? initialValue;
  final String directorName;
  final String writerName;
  final String producerName;
  final bool isViewOnly;
  final Map<String, dynamic> movieData;

  static final GlobalKey<_CrewNamesState> crewKey =
      GlobalKey<_CrewNamesState>();

  bool validate() {
    return crewKey.currentState?._validateFields() ?? false;
  }

  @override
  _CrewNamesState createState() => _CrewNamesState();
}

class _CrewNamesState extends State<CrewNames> {
  Uint8List? _directorImage;
  Uint8List? _writerImage;
  Uint8List? _producerImage;
  String? _directorError;
  String? _writerError;
  String? _producerError;

  bool _validateFields() {
    setState(() {
      _directorError = Validators.validateRequired(
        lettersOnly: true,
        MovieCubit.get(context).directorController.text,
        'Director Name',
      );
      _writerError = Validators.validateRequired(
        lettersOnly: true,
        MovieCubit.get(context).writerController.text,
        'Writer Name',
      );
      _producerError = Validators.validateRequired(
        lettersOnly: true,
        MovieCubit.get(context).producerController.text,
        'Producer Name',
      );
    });
    return _directorError == null &&
        _writerError == null &&
        _producerError == null;
  }

  @override
  void initState() {
    super.initState();
    final cubit = MovieCubit.get(context);

    cubit.directorController.text = widget.directorName;
    cubit.writerController.text = widget.writerName;
    cubit.producerController.text = widget.producerName;

    final crewImages = widget.movieData["crew_images"];

    if (crewImages != null && crewImages["director"] != null) {
      final imageBytes = base64Decode(crewImages["director"]);
      _directorImage = imageBytes;
      cubit.pickedDirectorImages = [
        PlatformFile(
            name: "director.png", size: imageBytes.length, bytes: imageBytes)
      ];
    }

    if (crewImages != null && crewImages["writer"] != null) {
      final imageBytes = base64Decode(crewImages["writer"]);
      _writerImage = imageBytes;
      cubit.pickedWriterImages = [
        PlatformFile(
            name: "writer.png", size: imageBytes.length, bytes: imageBytes)
      ];
    }

    if (crewImages != null && crewImages["producer"] != null) {
      final imageBytes = base64Decode(crewImages["producer"]);
      _producerImage = imageBytes;
      cubit.pickedProducerImages = [
        PlatformFile(
            name: "producer.png", size: imageBytes.length, bytes: imageBytes)
      ];
    }
  }

  Future<void> _pickImage({
    required Function(Uint8List?) setImage,
    required Function(PlatformFile?) saveToCubit,
  }) async {
    if (widget.isViewOnly) return;
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      final platformFile = PlatformFile(
        name: picked.name,
        size: bytes.length,
        bytes: bytes,
      );

      setState(() {
        setImage(bytes);
      });
      saveToCubit(platformFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = MovieCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(7.sp),
        child: Row(
          children: [
            // Director
            SizedBox(
              width: 100.w,
              child: PersonNameField(
                label: 'Director Name',
                imageBytes: _directorImage,
                controller: cubit.directorController,
                errorText: _directorError,
                validator: (value) => Validators.validateRequired(
                  value,
                  'Director Name',
                  lettersOnly: true,
                  maxLength: 50,
                ),
                onUpload: () => _pickImage(
                  setImage: (img) => _directorImage = img,
                  saveToCubit: (file) => cubit.pickedDirectorImages = [file],
                ),
                onDeleteImage: () {
                  setState(() => _directorImage = null);
                  cubit.pickedDirectorImages.clear();
                },
                isViewOnly: widget.isViewOnly,
              ),
            ),
            SizedBox(width: 6.w),

            // Writer
            SizedBox(
              width: 100.w,
              child: PersonNameField(
                label: 'Writer Name',
                imageBytes: _writerImage,
                controller: cubit.writerController,
                errorText: _writerError,
                validator: (value) => Validators.validateRequired(
                  value,
                  'Writer Name',
                  lettersOnly: true,
                  maxLength: 50,
                ),
                onUpload: () => _pickImage(
                  setImage: (img) => _writerImage = img,
                  saveToCubit: (file) => cubit.pickedWriterImages = [file],
                ),
                onDeleteImage: () {
                  setState(() => _writerImage = null);
                  cubit.pickedWriterImages.clear();
                },
                isViewOnly: widget.isViewOnly,
              ),
            ),
            SizedBox(width: 6.w),

            // Producer
            SizedBox(
              width: 100.w,
              child: PersonNameField(
                label: 'Producer Name',
                imageBytes: _producerImage,
                controller: cubit.producerController,
                errorText: _producerError,
                validator: (value) => Validators.validateRequired(
                  value,
                  'Producer Name',
                  lettersOnly: true,
                  maxLength: 50,
                ),
                onUpload: () => _pickImage(
                  setImage: (img) => _producerImage = img,
                  saveToCubit: (file) => cubit.pickedProducerImages = [file],
                ),
                onDeleteImage: () {
                  setState(() => _producerImage = null);
                  cubit.pickedProducerImages.clear();
                },
                isViewOnly: widget.isViewOnly,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
