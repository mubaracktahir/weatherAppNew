import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    List<Weather> weatherList;
    WeatherRepository weatherRepository = WeatherRepository();
    yield WeatherLoading();
    if (event is LoadWeather && event.cityName != null) {
      weatherList =
          await weatherRepository.getWeatherData(cityName: event.cityName);
    } else if (event is LoadWeather && event.cityName == null) {
      weatherList = await weatherRepository.getWeatherData();
    }

    List<Weather> tempList = [];
    for (var i = 0; i < weatherList.length - 1; i++) {
      var hour = weatherList[i].dateTime.hour;

      if (hour >= 0 && hour < 3) {
        tempList.add(weatherList[i]);
      } else if (hour >= 3 && hour < 6) {
        tempList.add(weatherList[i]);
      } else if (hour >= 6 && hour < 9) {
        tempList.add(weatherList[i]);
      } else if (hour >= 9 && hour < 12) {
        tempList.add(weatherList[i]);
      } else if (hour >= 12 && hour < 15) {
        tempList.add(weatherList[i]);
      } else if (hour >= 15 && hour < 18) {
        tempList.add(weatherList[i]);
      } else if (hour >= 18 && hour < 21) {
        tempList.add(weatherList[i]);
      }
    }

    weatherList = tempList;

    List<Weather> temp = [];
    for (var i = 0; i < weatherList.length - 1; i++) {
      if (weatherList[i].day != weatherList[i + 1].day) {
        temp.add(weatherList[i]);
      }
    }
    weatherList = temp;

    yield WeatherLoaded(weatherData: weatherList);
  }
}
