import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_color.dart';

class WeatherSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            AppColor.gradientTop,
            AppColor.gradientTop,
            AppColor.gradientBottom
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        )),
      ),
    );
  }
}
