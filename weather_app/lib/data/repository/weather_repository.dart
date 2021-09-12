import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/providers/weather_provider.dart';
import 'package:weather_app/data/repository/cached_pref.dart';
import 'package:weather_app/utils/format_weather_data.dart';

class WeatherRepository {
  String _cityName;
  // ignore: missing_return
  Future<List<Weather>> getWeatherData({String cityName}) async {
    var storedResponse = await CachedPref.getCachedWeatherData();

    //when there is cached data
    if (storedResponse != null) {
      return _structureWeatherData(rawWeatherData: storedResponse);
    }
    //when no cached data is not available
    else {
      if (cityName == null) {
        return _handleLocationData();
      } else {
        _cityName = cityName;
        return _handleSearchData();
      }
    }
  }

  // ignore: missing_return
  Future<List<Weather>> _structureWeatherData({String rawWeatherData}) async {
    var decodedResponse = jsonDecode(rawWeatherData);
    var cityName = decodedResponse['city']['name'];
    var weatherData = decodedResponse['list'];
    List<Weather> weatherList =
        weatherData.map<Weather>((e) => Weather.fromJson(e, cityName)).toList();

    return FormatWeatherData.asignColorsToData(weatherList: weatherList);
  }

  // ignore: missing_return
  Future<List<Weather>> _handleLocationData() async {
    var storedResponse = await CachedPref.getCachedWeatherData();
    if (storedResponse == null) {
      Position position;
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      var response = await WeatherProvider.FetchRawWeatherResponseOnLocation(
        position: position,
      );

      if (response.statusCode == 200) {
        await CachedPref.saveWeatherData(response.body);
        var rawData = await CachedPref.getCachedWeatherData();
        return _structureWeatherData(rawWeatherData: rawData);
      } else {
        throw ('Failed response');
      }
    }
  }

  // ignore: missing_return
  Future<List<Weather>> _handleSearchData() async {
    var response = await WeatherProvider.FetchRawWeatherResponseOnCity(
        cityName: _cityName);
    if (response.statusCode == 200) {
      await CachedPref.saveWeatherData(response.body);
      var rawData = await CachedPref.getCachedWeatherData();
      return _structureWeatherData(rawWeatherData: rawData);
    } else {
      throw ('Failed response');
    }
  }
}
