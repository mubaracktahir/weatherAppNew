import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

part 'filterd_weather_event.dart';
part 'filterd_weather_state.dart';

class FilterdWeatherBloc
    extends Bloc<FilterdWeatherEvent, FilterdWeatherState> {
  FilterdWeatherBloc() : super(FilteredWeatherLoading());

  @override
  Stream<FilterdWeatherState> mapEventToState(
    FilterdWeatherEvent event,
  ) async* {
    WeatherRepository weatherRepository = WeatherRepository();
    if (event is FilterdLoadingWeather) {
      yield FilteredWeatherLoading();
    } else if (event is FilterdLoadedWeatherDayEvent) {
      var day = event.day;
      List<Weather> weatherList = await weatherRepository.getWeatherData();
      List<Weather> temp = [];
      for (var i = 0; i < weatherList.length - 1; i++) {
        if (weatherList[i].day == day) {
          temp.add(weatherList[i]);
        }
      }
      weatherList = temp;
      yield FilterdWeatherLoaded(weatherData: weatherList);
    }
  }
}
