import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorRingWidget extends StatelessWidget {
  const ColorRingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 135.h,
      child: CustomPaint(
        painter: SegmentedCirclePainter(),
      ),
    );
  }
}

class SegmentedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 24;
    const double gapSize = 0.2;
    const int segments = 5;

    final List<Color> colors = [
      const Color(0xFF490073),
      const Color(0xFFC69CFF),
      const Color(0xFFE4C4FF),
      const Color(0xFFA464F2),
      const Color(0xFF7F33CC),
    ];

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    const double totalAngle = 2 * 3.141592653589793;
    const double sweepAngle = (totalAngle - (segments * gapSize)) / segments;

    for (int i = 0; i < segments; i++) {
      paint.color = colors[i];
      final double startAngle = i * (sweepAngle + gapSize);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
