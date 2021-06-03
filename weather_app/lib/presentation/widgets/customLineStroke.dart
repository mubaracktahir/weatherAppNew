import 'package:flutter/material.dart';

class CustomLineStroke extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double xDistance = 30;

    for (int i = 1; i <= 10; i++) {
      double height = i % 2 == 0 ? size.height * 0.5714 : size.height * 0.85714;
      double dOffset = i % 2 == 0 ? size.height * 0.28574 : 0;
      canvas.drawLine(
          Offset(xDistance, 20 + dOffset),
          Offset(xDistance, height + dOffset),
          Paint()
            ..strokeCap = StrokeCap.round
            ..color = Colors.white54
            ..strokeWidth = 5.0);
      xDistance += size.width / 10 - 5;
    }

    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.9);
    path_0.quadraticBezierTo(size.width * 0.0821875, size.height * 0.40,
        size.width * 0.1875000, size.height * 0.4000000);
    path_0.cubicTo(
        size.width * 0.2509375,
        size.height * 0.4190000,
        size.width * 0.2578125,
        size.height * 0.5930000,
        size.width * 0.3112500,
        size.height * 0.5720000);
    path_0.cubicTo(
        size.width * 0.3656250,
        size.height * 0.5615000,
        size.width * 0.3943750,
        size.height * 0.4905000,
        size.width * 0.4387500,
        size.height * 0.4980000);
    path_0.cubicTo(
        size.width * 0.4759375,
        size.height * 0.5230000,
        size.width * 0.5290625,
        size.height * 0.5950000,
        size.width * 0.5625000,
        size.height * 0.5820000);
    path_0.cubicTo(
        size.width * 0.6068750,
        size.height * 0.5595000,
        size.width * 0.6468750,
        size.height * 0.4465000,
        size.width * 0.6900000,
        size.height * 0.4440000);
    path_0.cubicTo(
        size.width * 0.7315625,
        size.height * 0.4475000,
        size.width * 0.7709375,
        size.height * 0.5725000,
        size.width * 0.8112500,
        size.height * 0.5700000);
    path_0.cubicTo(
        size.width * 0.8543750,
        size.height * 0.5685000,
        size.width * 0.9118750,
        size.height * 0.5655000,
        size.width * 0.9387500,
        size.height * 0.5480000);
    path_0.cubicTo(
        size.width * 0.9603125,
        size.height * 0.5305000,
        size.width * 0.9609375,
        size.height * 0.5175000,
        size.width * 0.9850000,
        size.height * 0.5020000);
    path_0.quadraticBezierTo(size.width * 0.9940625, size.height * 0.5025000,
        size.width * 0.9962500, size.height * 0.5360000);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
