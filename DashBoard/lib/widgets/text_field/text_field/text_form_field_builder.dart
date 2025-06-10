import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldBuilder extends StatelessWidget {
  const TextFormFieldBuilder({
    super.key,
    this.onTap,
    this.label,
    this.onChanged,
    required this.controller,
    required this.type,
    this.width,
    this.suffix,
    this.obsecure = true,
    this.color,
    this.validator,
    this.prefix,
    this.isIcon = true,
    this.prefixWidget,
    this.height,
    this.noIcon = false,
    this.maxlines = true,
    this.textAlign,
    this.disabledBorder,
    this.textAlignVer,
    this.enabledBorder,
    this.onSubmitted,
    this.icon,
    this.imagePath,
    this.suffixImagePath,
    this.prefixIcon,
    this.suffixIcon,
    this.hinitText,
    //this.initialValue,
  });
  //final String? initialValue ;
  final String? label;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? imagePath;
  final String? suffixImagePath;
  final bool obsecure;
  final bool isIcon;
  final bool noIcon;
  final Widget? suffix;
  final IconData? prefix;
  final Widget? prefixWidget;
  final TextEditingController controller;
  final TextInputType type;
  final double? width;
  final double? height;
  final Color? color;
  final String? Function(String?)? validator;
  final bool maxlines;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVer;
  final BorderSide? disabledBorder;
  final BorderSide? enabledBorder;
  final String? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hinitText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 333.w,
      height: height ?? 60.h,
      child: TextFormField(
        // initialValue: initialValue,
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxlines ? 1 : null,
        expands: maxlines ? false : true,
        controller: controller,
        obscureText: obsecure,
        textAlignVertical: textAlignVer ?? TextAlignVertical.top,
        style: const TextStyle(color: Colors.white),
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
          filled: true,
          fillColor: const Color(0xff2E126E).withOpacity(.4),
          prefixIcon: imagePath != null
              ? Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Image.asset(
                    imagePath!,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.fill,
                  ),
                )
              : (prefixIcon ??
                  (isIcon
                      ? Icon(prefix, color: const Color(0xFFA8A6A6))
                      : null)),
          suffixIcon: suffixIcon ??
              (obsecure
                  ? IconButton(
                      icon: const Icon(Icons.remove_red_eye,
                          color: Colors.white54),
                      onPressed: () {
                        // Toggle password visibility
                      },
                    )
                  : null),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0x40000000), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(width: 1.5, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(width: 2, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
