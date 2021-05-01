import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/weather_day_tile.dart';

class CustomButtomSheetTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        WeatherDayTile(
          height: _size.height * 0.80,
          width: double.infinity,
          day: 'Monday',
          degree: '40',
          minDegree: '56',
          maxDegree: '69',
        ),
        Positioned(
          left: _size.width / 2 - 25,
          top: -15,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: Colors.yellowAccent,
              ),
              child: Icon(
                Icons.cancel,
              ),
            ),
          ),
        )
      ],
    );
  }
}
