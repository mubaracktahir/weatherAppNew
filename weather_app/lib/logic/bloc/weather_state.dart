part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<Weather> weatherData;

  WeatherLoaded(this.weatherData);
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError(this.errorMessage);
}