import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_icons/weather_icons.dart';

import 'app_color.dart';

class FormatWeatherData {
  static String formatTimeStampToDay(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    DateFormat dateFormat = DateFormat(DateFormat.WEEKDAY);
    return dateFormat.format(dateTime);
  }

  static String fromTimeStampToHour(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    DateFormat dateFormate = DateFormat(DateFormat.HOUR24_MINUTE);
    return dateFormate.format(dateTime);
  }

  static List<Weather> assignWeatherIcon({List<Weather> weatherList}) {
    for (var i = 0; i < weatherList.length - 1; i++) {
      if (weatherList[i].id >= 200 && weatherList[i].id < 240) {
        weatherList[i].icon = WeatherIcons.thunderstorm;
      } else if (weatherList[i].id >= 300 && weatherList[i].id < 330) {
        weatherList[i].icon = WeatherIcons.sprinkle;
      } else if (weatherList[i].id >= 500 && weatherList[i].id <= 510) {
        weatherList[i].icon = WeatherIcons.rain;
      } else if (weatherList[i].id == 511) {
        weatherList[i].icon = WeatherIcons.sleet;
      } else if (weatherList[i].id >= 520 && weatherList[i].id < 540) {
        weatherList[i].icon = WeatherIcons.sprinkle;
      } else if (weatherList[i].id >= 600 && weatherList[i].id < 630) {
        weatherList[i].icon = WeatherIcons.snowflake_cold;
      } else if (weatherList[i].id > 700 && weatherList[i].id < 800) {
        weatherList[i].icon = WeatherIcons.dust;
      } else if (weatherList[i].id == 800) {
        DateTime dateTime = DateTime.parse(weatherList[i].date);
        int hour = dateTime.hour;

        if (hour < 16 && hour > 6) {
          weatherList[i].icon = WeatherIcons.day_sunny;
        } else {
          weatherList[i].icon = WeatherIcons.night_clear;
        }
      } else if (weatherList[i].id == 801) {
        weatherList[i].icon = WeatherIcons.day_cloudy;
      } else if (weatherList[i].id == 802) {
        weatherList[i].icon = WeatherIcons.cloud;
      } else if (weatherList[i].id >= 803) {
        weatherList[i].icon = WeatherIcons.cloudy;
      }

      // switch (weatherList[i].id) {
      //   case 200:
      //     weatherList[i].icon = WeatherIcons.thunderstorm;
      //     break;
      //   case 300:
      //     weatherList[i].icon = WeatherIcons.raindrops;
      //     break;
      //   case 500:
      //     weatherList[i].icon = WeatherIcons.rain_mix;
      //     break;
      //   case 600:
      //     weatherList[i].icon = WeatherIcons.snowflake_cold;
      //     break;
      //   case 700:
      //     weatherList[i].icon = WeatherIcons.dust;
      //     break;
      //   case 800:
      //     weatherList[i].icon = WeatherIcons.day_sunny;
      //     break;

      //   default:
      //     weatherList[i].icon = WeatherIcons.strong_wind;
      // }
    }
    return weatherList;
  }

  static List<Weather> asignColorsToData({List<Weather> weatherList}) {
    int tracker = 0;
    var dayTileColor = AppColor.monColor;
    for (var i = 0; i < weatherList.length - 1; i++) {
      weatherList[i].color = dayTileColor;
      if (weatherList[i].day != weatherList[i + 1].day) {
        tracker++;
        switch (tracker) {
          case 1:
            dayTileColor = AppColor.tueColor;
            break;
          case 2:
            dayTileColor = AppColor.wedColor;
            break;
          case 3:
            dayTileColor = AppColor.thurColor;
            break;
          case 4:
            dayTileColor = AppColor.friColor;
            break;
          default:
            dayTileColor = AppColor.monColor;
        }
      }
    }
    return assignWeatherIcon(weatherList: weatherList);
  }
}
