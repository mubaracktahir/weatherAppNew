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
    // TODO: implement mapEventToState
    if (event is LoadWeather) {
      WeatherRepository weatherRepository = WeatherRepository();
      yield WeatherLoading();
      List<Weather> weatherList = await weatherRepository.getWeatherData();
      //print(weatherList[0].description);
      yield WeatherLoaded(weatherData: weatherList);
    }
  }
}
