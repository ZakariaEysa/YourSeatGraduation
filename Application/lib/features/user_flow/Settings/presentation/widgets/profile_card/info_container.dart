import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoContainer extends StatefulWidget {
  final String? title;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputType type;

  const InfoContainer({
    required this.title,
    super.key,
    required this.controller,
    required this.type,
    required this.onChanged,
  });

  @override
  State<InfoContainer> createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      alignment: Alignment.centerLeft,
      width: 270.w,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.r),
        color: theme.colorScheme.primary.withOpacity(0.7),
      ),
      child: TextFormField(
        keyboardType: widget.type,
        cursorColor: theme.colorScheme.primary,
        onChanged: widget.onChanged,
        controller: widget.controller,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
