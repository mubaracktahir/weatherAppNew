import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_sheet_tile.dart';
import 'package:weather_app/presentation/widgets/custom_index_indicator.dart';
import 'package:weather_app/presentation/widgets/weather_day_tile.dart';
import 'package:weather_app/presentation/widgets/weather_display_tile.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherData weatherData = WeatherData();
  List<Weather> weathers;
  ScrollController _controller;
  int _currentIndex = 0;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _currentIndex = 1;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _currentIndex = 1;
      });
    }
  }

  @override
  void initState() {
    //_controller = ScrollController();
    //_controller.addListener(_scrollListener());
    weathers = weatherData.getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.lightbulb),
                //Spacer(),
                Text('ghjklnbnghjbn'),
                Icon(Icons.search),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            WeatherDisplayTile(),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'NEXT 15 DAYS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: _size.height * 0.29,
              child: ListView.builder(
                //controller: _controller,
                padding: EdgeInsets.all(0.0),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: weathers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: WeatherDayTile(
                      height: _size.height * 0.23,
                      width: _size.width * 0.33,
                      day: weathers[index].day,
                      icon: weathers[index].icon,
                      degree: '${weathers[index].humidity.toString()}°',
                      minDegree: '${weathers[index].minDegree.toString()}°',
                      maxDegree: '${weathers[index].maxDegree.toString()}°',
                      color: weathers[index].color,
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIndexIndicator(
                  color: _currentIndex == 1 ? Colors.red : Colors.grey,
                ),
                CustomIndexIndicator(
                  color: _currentIndex == 1 ? Colors.red : Colors.grey,
                ),
                CustomIndexIndicator(
                  color: _currentIndex == 1 ? Colors.red : Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
