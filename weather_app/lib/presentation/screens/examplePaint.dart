import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/customCloudySun.dart';

class ExamplePaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.white)),
          child: CustomPaint(
            size: Size(400, 400),
            painter: CustomCloudySun(isSmallSun: true),
          ),
        ),
      ),
    );
  }
}
