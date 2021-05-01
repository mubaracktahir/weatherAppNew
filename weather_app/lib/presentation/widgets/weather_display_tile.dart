import 'package:flutter/material.dart';

class WeatherDisplayTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      height: _size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.0),
        color: Colors.purpleAccent,
      ),
      child: Column(
        children: [
          Text(
            '25°',
            style: TextStyle(
              fontSize: 130.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            'Clouds & Sun',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              //height: 2.0,
            ),
          ),
          Text(
            'Humidy',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          Text(
            '34°',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
