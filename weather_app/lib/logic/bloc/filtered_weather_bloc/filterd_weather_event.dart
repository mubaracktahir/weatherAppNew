part of 'filterd_weather_bloc.dart';

@immutable
abstract class FilterdWeatherEvent {}

class FilterdLoadingWeather extends FilterdWeatherEvent {}

class FilterdLoadedWeatherDayEvent extends FilterdWeatherEvent {
  final String day;

  FilterdLoadedWeatherDayEvent({this.day});
}
