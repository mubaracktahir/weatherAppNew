import 'package:flutter/material.dart';

class CustomBackGroundCloud extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.60),
        size.width * 0.20, Paint()..color = Colors.grey);
    canvas.drawCircle(Offset(size.width * 0.60, size.height * 0.50),
        size.width * 0.25, Paint()..color = Colors.grey);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
