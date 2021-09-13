import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/logic/bloc/filtered_weather_bloc/filterd_weather_bloc.dart';
import 'package:weather_app/presentation/widgets/custom_detail_tile.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_icons/weather_icons.dart';

class CustomButtomSheetTile extends StatefulWidget {
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
                        BoxedIcon(
                          state.icon,
                          size: 100,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${state.temperature.round()}",
                              style: TextStyle(
                                fontSize: 61.0,
                                height: 2,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              WeatherIcons.celsius,
                              color: Colors.white,
                              size: 70,
                            )
                          ],
                        ),
                        WindIcon(
                          degree: state.windDegree,
                          color: Colors.white,
                          size: 50,
                        ),
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: dayWeather.length,
                              itemBuilder: (context, index) {
                                return CustomDetailTile(
                                  weatherTime: dayWeather[index].time,
                                  weatherIcon: dayWeather[index].icon,
                                  weatherDegree:
                                      "${dayWeather[index].temperature.round()}°",
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
