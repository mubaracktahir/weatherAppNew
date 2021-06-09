import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_color.dart';

class CustomCrossIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(size.width * 0.30, size.height * 0.4),
        Offset(size.width * 0.65, size.height * 0.70),
        Paint()
          ..strokeCap = StrokeCap.round
          ..color = AppColor.crossIconColor
          ..strokeWidth = 2.5);
    canvas.drawLine(
        Offset(size.width * 0.65, size.height * 0.4),
        Offset(size.width * 0.30, size.height * 0.70),
        Paint()
          ..strokeCap = StrokeCap.round
          ..color = AppColor.crossIconColor
          ..strokeWidth = 2.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
