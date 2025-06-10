import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/color_manager.dart';
import '../../../../../widgets/loading_indicator.dart';

class ButtonBuilder extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: isActivated && !isLoading ? onTap : null,
      child: Center(
        child: Container(
          width: width ?? screenWidth * 0.50,
          height: height ?? screenHeight * 0.07,
          decoration: BoxDecoration(
            color: !isActivated
                ? (buttonColor ?? ColorManager.primaryW).withOpacity(0.5)
                : buttonColor ?? ColorManager.primaryW,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: frameColor ?? buttonColor ?? ColorManager.primaryW,
              width: isActivated ? 1 : 0,
            ),
          ),
          child: isLoading
              ? const LoadingIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (image != null && image!.isNotEmpty)
                      Image.asset(
                        image!,
                        width: 75.w,
                        height: 75.h,
                        // fit: BoxFit.cover,
                      ),
                    Text(
                      text,
                      style: style ?? theme.textTheme.titleLarge,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
