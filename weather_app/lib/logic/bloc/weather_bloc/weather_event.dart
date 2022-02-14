part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadWeather extends WeatherEvent {
  final String cityName;

  LoadWeather({this.cityName});
}

class ReLoadWeather extends WeatherEvent {
  final String cityName;

  ReLoadWeather({this.cityName});
}
