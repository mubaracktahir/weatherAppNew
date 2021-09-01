part of 'filterd_weather_bloc.dart';

@immutable
abstract class FilterdWeatherState {}

class FilteredWeatherLoading extends FilterdWeatherState {}

class FilterdWeatherLoaded extends FilterdWeatherState {
  final List<Weather> weatherData;

  FilterdWeatherLoaded({this.weatherData});
}
