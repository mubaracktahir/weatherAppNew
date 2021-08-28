part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadWeather extends WeatherEvent {
  final String cityName;

  LoadWeather({this.cityName});
}

class LoadFilteredWeather extends WeatherEvent {
  final String day;
  LoadFilteredWeather({this.day});
}
