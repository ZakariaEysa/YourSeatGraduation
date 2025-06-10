import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/validators/Validators.dart';
import '../../../moives/data/movies_cubit/movies_cubit.dart';

class StoryLine extends StatefulWidget {
  const StoryLine({
    super.key,
    this.initialValue = '',
    this.readOnly = false,
  });

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String initialValue;
  final bool readOnly;

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  static void clearFields(BuildContext context) {
    //MovieCubit.get(context).storyLineController.clear();
    MovieCubit.get(context).storyLineController.clear(); // ربط مع الكيوبت
    formKey.currentState?.reset();
  }

  @override
  State<StoryLine> createState() => _StoryLineState();
}

class _StoryLineState extends State<StoryLine> {
  @override
  void initState() {
    super.initState();
    MovieCubit.get(context).storyLineController.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: StoryLine.formKey,
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(left: 70.w, right: 70.w, top: 8.h, bottom: 28.h),
          child: NewTextField(
            controller: MovieCubit.get(context).storyLineController,
            hintText: '\n\n Write story line here ...',
            borderColor: Colors.black,
            errorText: null,
            keyboardType: TextInputType.multiline,
            obscureText: false,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
            isMultiline: true,
            maxLines: 5,
            readOnly: widget.readOnly,
            onChanged: (_) {},
            validator: (value) {
              if (widget.readOnly) return null;
              return Validators.validateAnyText(
                value ?? '',
                'Story Line',
                maxLength: 1000,
              );
            },
          ),
        ),
      ),
    );
  }
}
