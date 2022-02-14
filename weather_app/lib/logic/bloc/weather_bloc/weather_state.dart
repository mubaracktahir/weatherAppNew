part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  final List<Weather> weatherData;

  WeatherState(this.weatherData);
}

class WeatherLoading extends WeatherState {
  WeatherLoading({List<Weather> weatherData}) : super(weatherData);
}

class WeatherLoaded extends WeatherState {
  final List<Weather> weatherData;

  WeatherLoaded({this.weatherData}) : super(weatherData);
}

class WeatherReLoaded extends WeatherState {
  final List<Weather> weatherData;

  WeatherReLoaded({this.weatherData}) : super(weatherData);
}

class WeatherFilteredData extends WeatherState {
  final List<Weather> weatherDayData;

  WeatherFilteredData({this.weatherDayData}) : super(null);
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError({this.errorMessage}) : super(null);
}
