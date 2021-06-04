import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:weather_app/utils/app_color.dart';

class Weather {
  final String day;
  final String iconUrl;
  final int humidity;
  final int degree;
  final int minDegree;
  final int maxDegree;
  final Color color;
  final String time;
  final String filledIconUrl;

  Weather({
    this.day,
    this.iconUrl,
    this.humidity,
    this.degree,
    this.minDegree,
    this.maxDegree,
    this.color,
    this.time,
    this.filledIconUrl,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        day: json['day'],
        iconUrl: json['iconUrl'],
        humidity: json['humidity'],
        degree: json['degree'],
        minDegree: json['minDegree'],
        maxDegree: json['maxDegree'],
        color: json['color'],
        time: json['time'],
        filledIconUrl: json['filledIconColor']);
  }
}

class WeatherData {
  List<Weather> getWeatherData() {
    List<Weather> weathers = [];
    Weather weather1 = Weather(
        day: 'Monday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 40,
        degree: 20,
        minDegree: 46,
        maxDegree: 72,
        color: AppColor.monColor,
        time: '12:00',
        filledIconUrl: 'assets/images/filled_sun.png');
    weathers.add(weather1);
    Weather weather2 = Weather(
        day: 'Tuesday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 60,
        degree: 20,
        minDegree: 48,
        maxDegree: 56,
        color: AppColor.tueColor,
        time: '14:00',
        filledIconUrl: 'assets/images/filled_rainy_cloud.png');
    weathers.add(weather2);
    Weather weather3 = Weather(
        day: 'Wednesday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 30,
        degree: 20,
        minDegree: 29,
        maxDegree: 34,
        color: AppColor.wedColor,
        time: '09:00',
        filledIconUrl: 'assets/images/filled_sunny_cloud.png');
    weathers.add(weather3);
    Weather weather4 = Weather(
        day: 'Thursday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 37,
        degree: 20,
        minDegree: 12,
        maxDegree: 18,
        color: AppColor.thurColor,
        time: '20:00',
        filledIconUrl: 'assets/images/filled_storm_cloud.png');
    weathers.add(weather4);
    Weather weather5 = Weather(
        day: 'Friday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 49,
        degree: 20,
        minDegree: 7,
        maxDegree: 9,
        color: AppColor.friColor,
        time: '13:00',
        filledIconUrl: 'assets/images/filled_sunny_cloud.png');
    weathers.add(weather5);
    return weathers;
  }
}
