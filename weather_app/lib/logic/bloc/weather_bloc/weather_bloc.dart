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

    yield WeatherLoaded(weatherData: _refactorWeatherData(weatherList));
  }

  List<Weather> _refactorWeatherData(List<Weather> weatherList) {
    List<Weather> temp = [];
    for (var i = 0; i < weatherList.length - 1; i++) {
      if (weatherList[i].day != weatherList[i + 1].day) {
        temp.add(weatherList[i]);
      }
    }
    weatherList = temp;
    return weatherList;
  }
}
