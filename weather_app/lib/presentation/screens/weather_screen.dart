import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_sheet_tile.dart';
import 'package:weather_app/presentation/widgets/custom_index_indicator.dart';
import 'package:weather_app/presentation/widgets/weather_day_tile.dart';
import 'package:weather_app/presentation/widgets/weather_display_tile.dart';
import 'package:weather_app/utils/app_color.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherData weatherData = WeatherData();
  List<Weather> weathers;
  ScrollController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    weathers = weatherData.getWeatherData();
    _controller = ScrollController(initialScrollOffset: 0.0);

    _controller.addListener(() {
      print('${_controller.offset} offset');
      print('${_controller.position.maxScrollExtent} maxScrollExtent');
      print('${_controller.position.minScrollExtent} minScrollExtent');
      if (_controller.offset == _controller.position.minScrollExtent) {
        setState(() {
          _currentIndex = 1;
        });
      }
      if (_controller.offset < _controller.position.maxScrollExtent &&
          _controller.offset > 0.0 &&
          !_controller.position.outOfRange) {
        setState(() {
          _currentIndex = 2;
        });
      }
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          _currentIndex = 3;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              'NEXT 5 DAYS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: _size.height * 0.29,
              child: ListView.builder(
                controller: _controller,
                padding: EdgeInsets.all(0.0),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: weathers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showBottomSheet(context);
                    },
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
                  color: _currentIndex == 1 || _currentIndex == 0
                      ? AppColor.thurColor
                      : AppColor.fadeWhite,
                ),
                CustomIndexIndicator(
                  color: _currentIndex == 2
                      ? AppColor.thurColor
                      : AppColor.fadeWhite,
                ),
                CustomIndexIndicator(
                  color: _currentIndex == 3
                      ? AppColor.thurColor
                      : AppColor.fadeWhite,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

showBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            40.0,
          ),
          topRight: Radius.circular(
            40.0,
          ),
        ),
      ),
      enableDrag: false,
      context: context,
      builder: (context) {
        return CustomButtomSheetTile();
      });
}
