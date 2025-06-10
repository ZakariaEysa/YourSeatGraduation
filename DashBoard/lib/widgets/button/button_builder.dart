// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../resources/color_manager.dart';
//
// class ButtonBuilder extends StatelessWidget {
//   const ButtonBuilder({
//     super.key,
//     required this.text,
//     required this.onTap,
//     this.width,
//     this.height,
//     this.style,
//     this.buttonColor,
//     this.isLoading = false,
//     this.frameColor,
//     this.isActivated = true,
//     this.image,
//     this.icon,
//   });
//
//   final String? image;
//   final IconData? icon;
//   final String text;
//   final VoidCallback onTap;
//   final double? width;
//   final double? height;
//   final TextStyle? style;
//   final bool isLoading;
//   final Color? buttonColor;
//   final Color? frameColor;
//   final bool isActivated;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return GestureDetector(
//       onTap: isActivated && !isLoading ? onTap : null,
//       child: Center(
//         child: Container(
//           width: width ?? screenWidth * 0.50,
//           height: height ?? screenHeight * 0.07,
//           decoration: BoxDecoration(
//             color: !isActivated
//                 ? (buttonColor ?? ColorManager.primaryW).withOpacity(0.5)
//                 : buttonColor ?? ColorManager.primaryW,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(
//               color: frameColor ?? buttonColor ?? ColorManager.primaryW,
//               width: isActivated ? 1 : 0,
//             ),
//           ),
//           child: isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (image != null && image!.isNotEmpty)
//                 Image.asset(
//                   image!,
//                   width: 75.w,
//                   height: 75.h,
//                 ),
//               if (icon != null)
//                 Icon(
//                   icon,
//                   size: 6.w,
//                 ),
//               if (image != null || icon != null)
//                 const SizedBox(width: 8),
//               Text(
//                 text,
//                 style: style ?? theme.textTheme.labelLarge,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/color_manager.dart';

class ButtonBuilder extends StatefulWidget {
  const ButtonBuilder({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.style,
    this.buttonColor,
    this.isLoading = false,
    this.frameColor,
    this.isActivated = true,
    this.image,
    this.borderRadius = 50.0,
    this.borderShape,
  });

  final String? image;
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final TextStyle? style;
  final bool isLoading;
  final Color? buttonColor;
  final Color? frameColor;
  final bool isActivated;
  final double borderRadius;
  final BorderRadiusGeometry? borderShape;

  @override
  State<ButtonBuilder> createState() => _ButtonBuilderState();
}

class _ButtonBuilderState extends State<ButtonBuilder> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.isActivated && !widget.isLoading ? widget.onTap : null,
        child: Center(
          child: AnimatedScale(
            scale: isHovered ? 1.03 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.width ?? screenWidth * 0.50,
              height: widget.height ?? screenHeight * 0.07,
              decoration: BoxDecoration(
                color: !widget.isActivated
                    ? (widget.buttonColor ?? ColorManager.primaryW)
                        .withOpacity(0.8)
                    : widget.buttonColor ?? ColorManager.primaryW,
                borderRadius: widget.borderShape ??
                    BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.frameColor ??
                      widget.buttonColor ??
                      ColorManager.primaryW,
                  width: widget.isActivated ? 1 : 0,
                ),
                boxShadow: isHovered
                    ? [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(3, 6),
                        )
                      ]
                    : [],
              ),
              child: widget.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.image != null && widget.image!.isNotEmpty)
                          Image.asset(
                            widget.image!,
                            width: 75.w,
                            height: 75.h,
                          ),
                        Text(
                          widget.text,
                          style: widget.style ?? theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
