import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather.dart';

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
    return weatherList;
  }
}
