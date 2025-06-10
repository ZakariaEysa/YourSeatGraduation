import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScaffoldF extends StatelessWidget {
  const ScaffoldF(
      {super.key,
      this.bottomNavigationBar,
      required this.body,
      this.appBar,
      this.actions});
  final Widget? bottomNavigationBar;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
          width: 500.w,
          height: 900.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(-0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [theme.primaryColor, theme.colorScheme.secondary],
            ),
          ),
          child: body),
      // appBar: title != null
      //     ? PreferredSize(
      //         preferredSize: Size.fromHeight(50.h),
      //         child: BuilderAppBar(
      //           actions: actions,
      //           title: title ?? "",
      //         ))
      //     : null,
    );
  }
}
