import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({this.dashWidth = 5.0, this.dashSpace = 3.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xff1A0E3D)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.8.w;

    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth.w, 0),
        paint,
      );

      startX += dashWidth.w + dashSpace.w;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
