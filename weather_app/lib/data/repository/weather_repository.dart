import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/providers/weather_provider.dart';
import 'package:weather_app/data/repository/cached_pref.dart';
import 'package:weather_app/utils/app_color.dart';

class WeatherRepository {
  String _cityName;
  // ignore: missing_return
  Future<List<Weather>> getWeatherData({String cityName}) async {
    var storedResponse = await CachedPref.getCachedWeatherData();
    //when there is cached data
    if (storedResponse != null) {
      return this._structureWeatherData(rawWeatherData: storedResponse);
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

  Future<List<Weather>> getDayWeatherData({String day}) {}

  // ignore: missing_return
  Future<List<Weather>> _structureWeatherData({String rawWeatherData}) async {
    var decodedResponse = jsonDecode(rawWeatherData);
    var cityName = decodedResponse['city']['name'];
    var weatherList = decodedResponse['list'];
    List<Weather> weatherData =
        weatherList.map<Weather>((e) => Weather.fromJson(e, cityName)).toList();
    int tracker = 0;
    var dayTileColor = AppColor.monColor;
    for (var i = 0; i < weatherData.length - 1; i++) {
      weatherData[i].color = dayTileColor;
      if (weatherData[i].day != weatherData[i + 1].day) {
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
    return weatherData;
  }

  // ignore: missing_return
  Future<List<Weather>> _handleLocationData() async {
    var storedResponse = await CachedPref.getCachedWeatherData();
    //print('${storedResponse} amaterasu');
    if (storedResponse == null) {
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
