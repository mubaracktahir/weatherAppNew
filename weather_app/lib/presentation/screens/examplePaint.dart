import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/customCloudySun.dart';
import 'package:weather_app/presentation/widgets/customLineStroke.dart';

class ExamplePaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white)),
              child: CustomPaint(
                size: Size(300, 70),
                painter: CustomLineStroke(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
