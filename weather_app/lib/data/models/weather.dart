import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:weather_app/data/models/weather_item.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/format_weather_data.dart';

class Weather {
  final String day;
  final String iconUrl;
  final int humidity;
  final double temperature;
  final double mintemperature;
  final double maxtemperature;
  final String description;
  Color color;
  final String time;
  final String filledIconUrl;
  final String city;
  List<Item> item;

  Weather({
    this.day,
    this.iconUrl,
    this.humidity,
    this.temperature,
    this.mintemperature,
    this.maxtemperature,
    this.description,
    this.color,
    this.time,
    this.filledIconUrl,
    this.city,
    this.item,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String cityName) {
    var _temp = json['main']['temp'];
    var _mintemperature = json["main"]["temp_min"];
    var _maxtemperature = json["main"]["temp_max"];
    var icon_url = "http://openweathermap.org/img/w/" +
        json["weather"][0]["icon"] +
        ".png";
    return Weather(
      day: FormatWeatherData.formatTimeStampToDay(json["dt_txt"]),
      iconUrl: icon_url,
      humidity: json["main"]['humidity'],
      temperature: _temp.toDouble(),
      mintemperature: _mintemperature.toDouble(),
      maxtemperature: _maxtemperature.toDouble(),
      description: json["weather"][0]["description"],
      color: json['color'],
      time: FormatWeatherData.fromTimeStampToHour(json["dt_txt"]),
      filledIconUrl: json['filledIconColor'],
      city: cityName,
    );
  }
}

class WeatherData {
  List<Weather> getWeatherData() {
    List<Weather> weathers = [];
    Weather weather1 = Weather(
        day: 'Monday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 40,
        temperature: 20,
        mintemperature: 46,
        maxtemperature: 72,
        color: AppColor.monColor,
        time: '12:00',
        filledIconUrl: 'assets/images/filled_sun.png');
    weathers.add(weather1);
    Weather weather2 = Weather(
        day: 'Tuesday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 60,
        temperature: 20,
        mintemperature: 48,
        maxtemperature: 56,
        color: AppColor.tueColor,
        time: '14:00',
        filledIconUrl: 'assets/images/filled_rainy_cloud.png');
    weathers.add(weather2);
    Weather weather3 = Weather(
        day: 'Wednesday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 30,
        temperature: 20,
        mintemperature: 29,
        maxtemperature: 34,
        color: AppColor.wedColor,
        time: '09:00',
        filledIconUrl: 'assets/images/filled_sunny_cloud.png');
    weathers.add(weather3);
    Weather weather4 = Weather(
        day: 'Thursday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 37,
        temperature: 20,
        mintemperature: 12,
        maxtemperature: 18,
        color: AppColor.thurColor,
        time: '20:00',
        filledIconUrl: 'assets/images/filled_storm_cloud.png');
    weathers.add(weather4);
    Weather weather5 = Weather(
        day: 'Friday',
        iconUrl: 'assets/images/icons8_sun_24px.png',
        humidity: 49,
        temperature: 20,
        mintemperature: 7,
        maxtemperature: 9,
        color: AppColor.friColor,
        time: '13:00',
        filledIconUrl: 'assets/images/filled_sunny_cloud.png');
    weathers.add(weather5);
    return weathers;
  }
}
