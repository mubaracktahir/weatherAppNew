part of 'filterd_weather_bloc.dart';

@immutable
abstract class FilterdWeatherState {}

class FilteredWeatherLoading extends FilterdWeatherState {}

class FilterdWeatherLoaded extends FilterdWeatherState {
  final List<Weather> weatherData;
  final IconData icon;
  final double temperature;

  FilterdWeatherLoaded({this.weatherData, this.icon, this.temperature});
}
