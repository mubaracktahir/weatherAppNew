import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/logic/bloc/filtered_weather_bloc/filterd_weather_bloc.dart';
import 'package:weather_app/presentation/widgets/custom_detail_tile.dart';
import 'package:weather_app/utils/app_color.dart';

class CustomButtomSheetTile extends StatefulWidget {
  final String day;

  const CustomButtomSheetTile({this.day});

  @override
  _CustomButtomSheetTileState createState() => _CustomButtomSheetTileState();
}

class _CustomButtomSheetTileState extends State<CustomButtomSheetTile>
    with SingleTickerProviderStateMixin {
  AnimationController _bottomController;
  Animation<double> _animation;
  WeatherData weatherData = WeatherData();
  List<Weather> weathers;

  @override
  void initState() {
    weathers = weatherData.getWeatherData();
    _bottomController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..forward();
    _animation =
        CurvedAnimation(parent: _bottomController, curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * 0.85,
      width: double.infinity,
      child: BlocBuilder<FilterdWeatherBloc, FilterdWeatherState>(
        builder: (context, state) {
          BlocProvider.of<FilterdWeatherBloc>(context)
              .add(FilterdLoadedWeatherDayEvent(day: widget.day));
          if (state is FilterdWeatherLoaded) {
            var dayWeather = state.weatherData;
            return ScaleTransition(
              scale: _animation,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 45.0),
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Text(
                          dayWeather.first.day,
                          style: TextStyle(
                            height: 2.0,
                            fontSize: 47.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '☼',
                          style: TextStyle(
                            fontSize: 100.0,
                            height: 1,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '23°',
                          style: TextStyle(
                            fontSize: 61.0,
                            height: 2,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '52°',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                height: 2,
                                color: Colors.white54,
                              ),
                            ),
                            SizedBox(
                              width: 35.0,
                            ),
                            Text(
                              '67°',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                height: 2,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: _size.width / 2 - 25,
                    top: -25,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(300),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.close,
                          color: AppColor.crossIconColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: _size.height * 0.20,
                        margin: EdgeInsets.only(
                            right: 12.0, left: 12.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: ScrollConfiguration(
                          behavior: ScrollBehavior(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dayWeather.length,
                              itemBuilder: (context, index) {
                                return CustomDetailTile(
                                  weatherTime: dayWeather[index].time,
                                  weatherIconUrl: weathers[0].filledIconUrl,
                                  weatherDegree:
                                      dayWeather[index].temperature.toString(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// const apiKey = "e5ce4396a742a3620f294226a89898b4";
// "http://api.openweathermap.org/data/2.5/forecast"
//         "?q=lokoja&cnt=40&appid=e5ce4396a742a3620f294226a89898b4&units=metric"