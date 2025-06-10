import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class MovieTextFieldLabel extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextEditingController controller;
  final String? errorText;
  final Color errorColor;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const MovieTextFieldLabel({
    Key? key,
    this.initialValue,
    required this.label,
    required this.controller,
    this.errorText,
    this.errorColor = Colors.red,
    this.hintText,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 5.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        NewTextField(
          initialValue: initialValue,
          controller: controller,
          keyboardType: TextInputType.text, // يجب أن يكون text وليس multiline إذا كنت تريد سطر واحد
          hintText: hintText,
          borderColor: errorText != null ? errorColor : Colors.black,
          errorText: errorText,
          readOnly: readOnly,
          onChanged: onChanged,
          // تأكد من عدم وجود أي قيود إضافية هنا
        ),

      ],
    );
  }
}