import 'package:intl/intl.dart';

class FormatWeatherData {
  static String formatTimeStampToDay(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    DateFormat dateFormat = DateFormat(DateFormat.WEEKDAY);
    return dateFormat.format(dateTime);
  }
}
