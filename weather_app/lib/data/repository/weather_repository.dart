import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/providers/weather_provider.dart';

class WeatherRepository {
  String _cityName;
  Future<List<Weather>> getWeatherData({String cityName}) {
    if (cityName == null) {
      return this._handleLocationData();
    } else {
      _cityName = cityName;
      return this._handleSearchData();
    }
  }

  // ignore: missing_return
  Future<List<Weather>> _handleLocationData() async {
    print('amaterasu ');
    List<Weather> emList;
    Position position;
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).catchError((e) => print(e.message));

    var response = await WeatherProvider.FetchWeatherResponseOnLocation(
      position: position,
    );

    if (response.statusCode == 200) {
      //TODO HANDLE DATA ARRANGEMENT

      print(response.body);
    } else {
      return emList;
    }
  }

  // ignore: missing_return
  Future<List<Weather>> _handleSearchData() async {
    print("Hello5");
    List<Weather> emList;
    var response =
        await WeatherProvider.FetchWeatherResponseOnCity(cityName: _cityName);
    if (response.statusCode == 200) {
      //TODO HANDLE DATA ARRANGEMENT
      print(response.body);
    } else {
      return emList;
    }
  }
}
