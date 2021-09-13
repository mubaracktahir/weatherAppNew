part of 'filterd_weather_bloc.dart';

@immutable
abstract class FilterdWeatherEvent {}

class FilterdLoadingWeather extends FilterdWeatherEvent {}

class FilterdLoadedWeatherDayEvent extends FilterdWeatherEvent {
  final String day;
  final IconData icon;
  final double temperature;

  FilterdLoadedWeatherDayEvent({this.day, this.icon, this.temperature});
}
