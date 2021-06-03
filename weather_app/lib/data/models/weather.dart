import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:weather_app/utils/app_color.dart';

class Weather {
  final String day;
  final String icon;
  final int humidity;
  final int degree;
  final int minDegree;
  final int maxDegree;
  final Color color;

  Weather({
    this.day,
    this.icon,
    this.humidity,
    this.degree,
    this.minDegree,
    this.maxDegree,
    this.color,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      day: json['day'],
      icon: json['icon'],
      humidity: json['humidity'],
      degree: json['degree'],
      minDegree: json['minDegree'],
      maxDegree: json['maxDegree'],
      color: json['color'],
    );
  }
}

class WeatherData {
  List<Weather> getWeatherData() {
    List<Weather> weathers = [];
    Weather weather1 = Weather(
      day: 'Monday',
      icon: '☼',
      humidity: 40,
      degree: 20,
      minDegree: 46,
      maxDegree: 72,
      color: AppColor.monColor,
    );
    weathers.add(weather1);
    Weather weather2 = Weather(
      day: 'Tuesday',
      icon: '☼',
      humidity: 60,
      degree: 20,
      minDegree: 48,
      maxDegree: 56,
      color: AppColor.tueColor,
    );
    weathers.add(weather2);
    Weather weather3 = Weather(
      day: 'Wednesday',
      icon: '☼',
      humidity: 30,
      degree: 20,
      minDegree: 29,
      maxDegree: 34,
      color: AppColor.wedColor,
    );
    weathers.add(weather3);
    Weather weather4 = Weather(
      day: 'Thursday',
      icon: '☼',
      humidity: 37,
      degree: 20,
      minDegree: 12,
      maxDegree: 18,
      color: AppColor.thurColor,
    );
    weathers.add(weather4);
    Weather weather5 = Weather(
      day: 'Friday',
      icon: '☼',
      humidity: 49,
      degree: 20,
      minDegree: 7,
      maxDegree: 9,
      color: AppColor.friColor,
    );
    weathers.add(weather5);
    return weathers;
  }
}
