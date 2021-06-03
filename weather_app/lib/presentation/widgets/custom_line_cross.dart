import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_color.dart';

class CustomLineCross extends CustomPainter {
  final bool isSmallCross;

  CustomLineCross({this.isSmallCross});
  @override
  void paint(Canvas canvas, Size size) {
    if (isSmallCross) {
      canvas.drawLine(
          Offset(0, size.height),
          Offset(size.width * 0.07, size.height * 0.93),
          Paint()
            ..strokeCap = StrokeCap.round
            ..color = AppColor.backgroundDesign
            ..strokeWidth = 2.0);
      canvas.drawLine(
          Offset(size.width * 0.07, size.height),
          Offset(0, size.height * 0.93),
          Paint()
            ..strokeCap = StrokeCap.round
            ..color = AppColor.backgroundDesign
            ..strokeWidth = 2.0);
    } else {
      canvas.drawLine(
          Offset(0, size.height),
          Offset(size.width * 0.15, size.height * 0.85),
          Paint()
            ..strokeCap = StrokeCap.round
            ..color = AppColor.backgroundDesign
            ..strokeWidth = 5.0);
      canvas.drawLine(
          Offset(size.width * 0.15, size.height),
          Offset(0, size.height * 0.85),
          Paint()
            ..strokeCap = StrokeCap.round
            ..color = AppColor.backgroundDesign
            ..strokeWidth = 5.0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
