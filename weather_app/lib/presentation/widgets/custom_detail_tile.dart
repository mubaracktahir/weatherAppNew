import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class CustomDetailTile extends StatelessWidget {
  final String weatherTime;
  final IconData weatherIcon;
  final String weatherDegree;

  const CustomDetailTile(
      {Key key, this.weatherTime, this.weatherIcon, this.weatherDegree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(weatherTime),
          BoxedIcon(weatherIcon),
          Text(weatherDegree),
        ],
      ),
    );
  }
}
