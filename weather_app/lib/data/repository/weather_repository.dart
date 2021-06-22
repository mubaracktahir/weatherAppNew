import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/providers/weather_provider.dart';
import 'package:weather_app/data/repository/cached_pref.dart';

class WeatherRepository {
  String _cityName;
  Future<List<Weather>> getWeatherData({String cityName}) async {
    var storedResponse = await CachedPref.getCachedWeatherData();
    //when there is cached data
    if (storedResponse != null) {
      this._structureWeatherData(rawWeatherData: storedResponse);
    }
    //when there is no cached data
    else {
      if (cityName == null) {
        return this._handleLocationData();
      } else {
        _cityName = cityName;
        return this._handleSearchData();
      }
    }
  }

  // ignore: missing_return
  Future<List<Weather>> _structureWeatherData({String rawWeatherData}) async {
    var decodedResponse = jsonDecode(rawWeatherData);

    var cityName = decodedResponse['city']['name'];
    var weatherList = decodedResponse['list'];
    //print(weatherList[0]);
    List<Weather> weatherData =
        weatherList.map<Weather>((e) => Weather.fromJson(e, cityName)).toList();
    print(weatherData[0].day);
    return weatherData;
  }

  // ignore: missing_return
  Future<List<Weather>> _handleLocationData() async {
    var storedResponse = await CachedPref.getCachedWeatherData();
    print('${storedResponse} amaterasu');
    if (storedResponse == null) {
      print('amaterasu ');
      List<Weather> emList;
      Position position;
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      var response = await WeatherProvider.FetchRawWeatherResponseOnLocation(
        position: position,
      );

      if (response.statusCode == 200) {
        //TODO HANDLE DATA ARRANGEMENT

        await CachedPref.saveWeatherData(response.body);
        var rep = await CachedPref.getCachedWeatherData();
        //print('${rep} from cached');
        //print(response.body);

      } else {
        //print(response.body);
        return emList;
      }
    }
  }

  // ignore: missing_return
  Future<List<Weather>> _handleSearchData() async {
    print("Hello5");
    List<Weather> emList;
    var response = await WeatherProvider.FetchRawWeatherResponseOnCity(
        cityName: _cityName);
    if (response.statusCode == 200) {
      //TODO HANDLE DATA ARRANGEMENT

      print(response.body);
    } else {
      print(response.body);
      return emList;
    }
  }
}
