import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final Color borderColor;
  final Color errorColor;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? errorStyle;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final bool isMultiline;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool expands;
  final bool enabled;
  final bool readOnly;

  const NewTextField({
    super.key,
    this.controller,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.borderColor = Colors.grey,
    this.errorColor = Colors.red,
    this.errorText,
    this.contentPadding,
    this.errorStyle,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.isMultiline = false,
    this.hintStyle,
    this.textStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.expands = false,
    this.enabled = true,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMaxLines = isMultiline ? (maxLines ?? 5) : 1;
    final effectiveKeyboardType = isMultiline
        ? TextInputType.multiline
        : (keyboardType ?? TextInputType.text);

    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      style: textStyle ??
          TextStyle(color: enabled ? Colors.black : Colors.black54),
      textAlign: textAlign,
      keyboardType: effectiveKeyboardType,
      maxLines: expands ? null : effectiveMaxLines,
      minLines: effectiveMaxLines,
      expands: expands,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[200],
        hintText: hintText,
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: enabled ? borderColor : Colors.grey, width: 1.5),
            ),
        errorText: errorText,
        errorStyle: errorStyle ??
            TextStyle(
              fontSize: 12,
              color: errorColor,
              height: 0.8,
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: errorColor, width: 1.5),
        ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 12,
              vertical: isMultiline ? 16 : 12,
            ),
        isDense: true,
      ),
    );
  }
}
