import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_sheet_tile.dart';

class WeatherDayTile extends StatelessWidget {
  final String day;
  final String icon;
  final String degree;
  final String minDegree;
  final String maxDegree;
  final Color color;

  const WeatherDayTile({
    Key key,
    this.day,
    this.icon,
    this.degree,
    this.minDegree,
    this.maxDegree,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: _size.height * 0.25,
          width: _size.width * 0.33,
          padding: EdgeInsets.only(top: 15.0),
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: this.color,
            boxShadow: [
              BoxShadow(
                color: this.color == null
                    ? Colors.black26
                    : this.color.withOpacity(0.4),
                offset: Offset(8, 8),
                blurRadius: 3.0,
                //spreadRadius: 1.0,
              )
            ],
          ),
          child: Column(
            children: [
              Text(
                this.day == null ? '' : this.day,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                this.icon == null ? '' : this.icon,
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              ),
              Text(
                this.degree == null ? '' : this.degree,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.minDegree == null ? '' : this.minDegree,
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    this.maxDegree == null ? '' : this.maxDegree,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
