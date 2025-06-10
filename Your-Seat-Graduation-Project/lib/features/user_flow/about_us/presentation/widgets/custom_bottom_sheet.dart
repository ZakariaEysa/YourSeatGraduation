import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resources/app_styles_manager.dart';

class CustomBottomSheet extends StatefulWidget {
  final double initialHeight;
  final double maxHeight;
  final double minHeight;
  final DraggableScrollableController scrollController;
  final String content;
  final Widget? bottomWidget;
  final String title;

  const CustomBottomSheet({
    super.key,
    required this.initialHeight,
    required this.maxHeight,
    required this.minHeight,
    required this.scrollController,
    required this.content,
    this.bottomWidget,
    required this.title,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    var theme = Theme.of(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 13.w), // تعديل باستخدام ScreenUtil
      child: DraggableScrollableSheet(
        controller: widget.scrollController,
        initialChildSize: widget.initialHeight,
        minChildSize: widget.minHeight,
        maxChildSize: widget.maxHeight,
        expand: false,
        builder:
            (BuildContext context, ScrollController innerScrollController) {
          return Container(
            decoration: AppStylesManager.backGroundDecorations(context),
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    // AppLogs.debugLog(widget.scrollController.size.toString());

                    double newSize = widget.scrollController.size -
                        (details.delta.dy / MediaQuery.of(context).size.height);
                    if (newSize >= 0 && newSize <= 1) {
                      // AppLogs.errorLog(newSize.toString());
                      value = newSize;

                      widget.scrollController.jumpTo(newSize);
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w, // تعديل باستخدام ScreenUtil
                      vertical: 15.h, // تعديل باستخدام ScreenUtil
                    ),
                    child: Text(
                      widget.title,
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 24.sp), // استخدام ScreenUtil لضبط الحجم
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: innerScrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 26.w), // تعديل باستخدام ScreenUtil
                      child: Column(
                        children: [
                          SizedBox(height: 30.h), // تعديل باستخدام ScreenUtil
                          if (value != 0 && value > .15 ||
                              widget.title != lang.contactUs)
                            Text(
                              widget.content,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize:
                                      12.sp), // استخدام ScreenUtil لضبط الحجم
                            ),
                          SizedBox(height: 20.h), // تعديل باستخدام ScreenUtil
                          if (widget.bottomWidget != null)
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  top: 20.h), // تعديل باستخدام ScreenUtil
                              child: widget.bottomWidget,
                            ),
                          SizedBox(height: 300.h), // تعديل باستخدام ScreenUtil
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
