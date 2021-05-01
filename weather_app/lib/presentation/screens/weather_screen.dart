import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_sheet_tile.dart';
import 'package:weather_app/presentation/widgets/weather_day_tile.dart';
import 'package:weather_app/presentation/widgets/weather_display_tile.dart';

class WeatherScreen extends StatelessWidget {
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
            GestureDetector(
              onTap: () {
                showButtomSheet(context);
              },
              child: WeatherDayTile(
                height: _size.height * 0.25,
                width: _size.width * 0.33,
                day: 'Monday',
                icon: '☼',
                degree: '40°',
                minDegree: '56°',
                maxDegree: '69°',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showButtomSheet(BuildContext context) {
  showModalBottomSheet(
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
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Hero(
        tag: 'draw',
        child: CustomButtomSheetTile(),
      );
    },
  );
}
