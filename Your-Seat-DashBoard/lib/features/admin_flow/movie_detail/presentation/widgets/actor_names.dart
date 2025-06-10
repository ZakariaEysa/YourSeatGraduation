// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:file_picker/file_picker.dart';
// import '../../../../../widgets/validators/Validators.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
//
// import '../../../moives/data/movies_cubit/movies_cubit.dart';
//
// class ActorNames extends StatefulWidget {
//   const ActorNames({
//     super.key,
//     required this.actors,
//     this.isViewOnly = false,
//   });
//
//   final List<String> actors;
//   final bool isViewOnly;
//
//   static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   static bool validate() {
//     return formKey.currentState?.validate() ?? false;
//   }
//
//   @override
//   State<ActorNames> createState() => _ActorNamesState();
// }
//
// class _ActorNamesState extends State<ActorNames> {
//   List<PlatformFile?> _pickedImages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     MovieCubit.get(context).actorControllers = widget.actors.map((name) => TextEditingController(text: name)).toList();
//     _pickedImages = List.generate(MovieCubit.get(context).actorControllers!.length, (_) => null);
//
//     if (MovieCubit.get(context).actorControllers!.isEmpty) _addActorField();
//   }
//
//   void _addActorField() {
//     MovieCubit.get(context).actorControllers!.add(TextEditingController());
//     _pickedImages.add(null);
//     setState(() {});
//   }
//
//   void _removeActorField(int index) {
//     if (MovieCubit.get(context).actorControllers!.length > 1) {
//       MovieCubit.get(context).actorControllers!.removeAt(index);
//       _pickedImages.removeAt(index);
//       setState(() {});
//     }
//   }
//
//   Future<void> _pickImage(int index) async {
//     if (widget.isViewOnly) return;
//
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       withData: true,
//     );
//
//     if (result != null && result.files.single.bytes != null) {
//       setState(() {
//         _pickedImages[index] = result.files.single;
//       });
//     }
//   }
//
//   void _deleteImage(int index) {
//     setState(() {
//       _pickedImages[index] = null;
//     });
//   }
//
//   Widget _buildActorFields() {
//     List<Widget> rows = [];
//     for (int i = 0; i < MovieCubit.get(context).actorControllers!.length; i += 2) {
//       final hasSecond = i + 1 < MovieCubit.get(context).actorControllers!.length;
//
//       rows.add(Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: PersonNameField(
//               label: 'Actor Name',
//               controller: MovieCubit.get(context).actorControllers![i],
//               imageBytes: _pickedImages[i]?.bytes,
//               onAdd: widget.isViewOnly ? null : _addActorField,
//               onDelete: widget.isViewOnly || i == 0 ? null : () => _removeActorField(i),
//               onUpload: () => _pickImage(i),
//               onDeleteImage: () => _deleteImage(i),
//               validator: (value) => Validators.validateRequired(
//                 value,
//                 'Actor Name',
//                 lettersOnly: true,
//                 maxLength: 50,
//               ),
//               isViewOnly: widget.isViewOnly,
//               isFirst: i == 0,
//             ),
//           ),
//           SizedBox(width: 10.w),
//           if (hasSecond)
//             Expanded(
//               child: PersonNameField(
//                 label: 'Actor Name',
//                 controller: MovieCubit.get(context).actorControllers![i + 1],
//                 imageBytes: _pickedImages[i + 1]?.bytes,
//                 onAdd: null,
//                 onDelete: widget.isViewOnly ? null : () => _removeActorField(i + 1),
//                 onUpload: () => _pickImage(i + 1),
//                 onDeleteImage: () => _deleteImage(i + 1),
//                 validator: (value) => Validators.validateRequired(
//                   value,
//                   'Actor Name',
//                   lettersOnly: true,
//                   maxLength: 50,
//                 ),
//                 isViewOnly: widget.isViewOnly,
//                 isFirst: false,
//               ),
//             )
//           else
//             Expanded(child: Container()),
//         ],
//       ));
//
//       rows.add(SizedBox(height: 10.h));
//     }
//
//     return Column(children: rows);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: ActorNames.formKey,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 62.w, vertical: 15.h),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           padding: EdgeInsets.all(10.sp),
//           child: _buildActorFields(),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../widgets/validators/Validators.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
import '../../../moives/data/movies_cubit/movies_cubit.dart';

class ActorNames extends StatefulWidget {
  const ActorNames({
    super.key,
    required this.movieData,
    required this.actors,
    this.isViewOnly = false,
  });

  final List<String> actors;
  final bool isViewOnly;
  final Map<String, dynamic> movieData;

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  State<ActorNames> createState() => _ActorNamesState();
}

class _ActorNamesState extends State<ActorNames> {
  List<PlatformFile?> _pickedImages = [];
  List<Uint8List?> _actorImages = [];

  @override
  void initState() {
    super.initState();
    final cubit = MovieCubit.get(context);

    cubit.actorControllers =
        widget.actors.map((name) => TextEditingController(text: name)).toList();

    _pickedImages = List.generate(cubit.actorControllers!.length, (_) => null);
    _actorImages = List.generate(cubit.actorControllers!.length, (_) => null);
    cubit.pickedActorImages =
        List.generate(cubit.actorControllers!.length, (_) => null);

    // قراءة الصور من Base64
    if (widget.movieData["cast_images"] != null &&
        widget.movieData["cast_images"] is List) {
      List<dynamic> images = widget.movieData["cast_images"];
      for (int i = 0; i < images.length && i < _actorImages.length; i++) {
        if (images[i] != null && images[i] is String) {
          Uint8List bytes = base64Decode(images[i]);
          _actorImages[i] = bytes;
          cubit.pickedActorImages[i] = PlatformFile(
            name: 'actor_$i.png',
            size: bytes.length,
            bytes: bytes,
          );
        }
      }
    }

    if (cubit.actorControllers!.isEmpty) _addActorField();
  }

  void _addActorField() {
    final cubit = MovieCubit.get(context);
    cubit.actorControllers!.add(TextEditingController());
    _pickedImages.add(null);
    _actorImages.add(null);
    cubit.pickedActorImages.add(null);
    setState(() {});
  }

  void _removeActorField(int index) {
    final cubit = MovieCubit.get(context);
    if (cubit.actorControllers!.length > 1) {
      cubit.actorControllers!.removeAt(index);
      _pickedImages.removeAt(index);
      _actorImages.removeAt(index);
      cubit.pickedActorImages.removeAt(index);
      setState(() {});
    }
  }

  Future<void> _pickImage(int index) async {
    if (widget.isViewOnly) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      final file = result.files.single;
      setState(() {
        _pickedImages[index] = file;
        _actorImages[index] = file.bytes;
      });

      final cubit = MovieCubit.get(context);
      cubit.pickedActorImages[index] = file;
    }
  }

  void _deleteImage(int index) {
    final cubit = MovieCubit.get(context);
    setState(() {
      _pickedImages[index] = null;
      _actorImages[index] = null;
    });
    cubit.pickedActorImages[index] = null;
  }

  Widget _buildActorFields() {
    final cubit = MovieCubit.get(context);
    List<Widget> rows = [];
    for (int i = 0; i < cubit.actorControllers!.length; i += 2) {
      final hasSecond = i + 1 < cubit.actorControllers!.length;

      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PersonNameField(
              label: 'Actor Name',
              controller: cubit.actorControllers![i],
              imageBytes: _actorImages[i],
              onAdd: widget.isViewOnly ? null : _addActorField,
              onDelete: widget.isViewOnly || i == 0
                  ? null
                  : () => _removeActorField(i),
              onUpload: () => _pickImage(i),
              onDeleteImage: () => _deleteImage(i),
              validator: (value) => Validators.validateRequired(
                value,
                'Actor Name',
                lettersOnly: true,
                maxLength: 50,
              ),
              isViewOnly: widget.isViewOnly,
              isFirst: i == 0,
            ),
          ),
          SizedBox(width: 10.w),
          if (hasSecond)
            Expanded(
              child: PersonNameField(
                label: 'Actor Name',
                controller: cubit.actorControllers![i + 1],
                imageBytes: _actorImages[i + 1],
                onAdd: null,
                onDelete:
                    widget.isViewOnly ? null : () => _removeActorField(i + 1),
                onUpload: () => _pickImage(i + 1),
                onDeleteImage: () => _deleteImage(i + 1),
                validator: (value) => Validators.validateRequired(
                  value,
                  'Actor Name',
                  lettersOnly: true,
                  maxLength: 50,
                ),
                isViewOnly: widget.isViewOnly,
                isFirst: false,
              ),
            )
          else
            Expanded(child: Container()),
        ],
      ));

      rows.add(SizedBox(height: 10.h));
    }

    return Column(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ActorNames.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 62.w, vertical: 15.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(10.sp),
          child: _buildActorFields(),
        ),
      ),
    );
  }
}
