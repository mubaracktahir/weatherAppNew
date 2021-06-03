import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_color.dart';

class CustomCloudySun extends CustomPainter {
  final bool isSmallSun;

  CustomCloudySun({this.isSmallSun});
  @override
  void paint(Canvas canvas, Size size) {
    if (isSmallSun) {
      canvas.drawCircle(Offset(size.width * 0.70, size.height * 0.26),
          size.width * 0.08, Paint()..color = AppColor.homeSunColor);
    } else {
      canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.40),
          size.width * 0.20, Paint()..color = AppColor.homeSunColor);
    }
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.60),
        size.width * 0.20, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(size.width * 0.60, size.height * 0.50),
        size.width * 0.25, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
