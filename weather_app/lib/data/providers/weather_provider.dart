import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

const apiKey = "e5ce4396a742a3620f294226a89898b4";

class WeatherProvider {
  //get weather base on geolocation
  //api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}

  //get weather base on city name
  //api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}

  static Future<http.Response> FetchRawWeatherResponseOnCity(
      {String cityName}) async {
    final response = await http.get(
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=${apiKey}");
    return Future<http.Response>.value(response);
  }

  static Future<http.Response> FetchRawWeatherResponseOnLocation(
      {Position position}) async {
    final response = await http.get(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=${apiKey}");
    if (response.statusCode == 200) {
      return Future<http.Response>.value(response);
    }
  }
}
