import 'package:shared_preferences/shared_preferences.dart';

const String cachedKey = 'WEATHER_DATA';

class CachedPref {
  static Future<bool> saveWeatherData(String weatherData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(cachedKey, weatherData);
  }

  static Future<String> getCachedWeatherData() async {
    String data;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      data = prefs.getString(cachedKey);
    } catch (e) {
      return e;
    }
    return data;
  }

  static Future<bool> clearCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(cachedKey);
  }
}
