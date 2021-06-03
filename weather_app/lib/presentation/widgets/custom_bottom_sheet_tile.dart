import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/weather_day_tile.dart';

class CustomButtomSheetTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: _size.height * 0.8,
          width: double.infinity,
          padding: EdgeInsets.only(top: 45.0),
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              offset: Offset(8, 8),
              blurRadius: 3.0,
              //spreadRadius: 1.0,
            )
          ]),
          child: Column(
            children: [
              Text(
                'Monday',
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
                      color: Colors.grey.withOpacity(0.4),
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
                color: Colors.white,
              ),
              child: Icon(
                Icons.cancel,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _size.height * (147 / 896),
              margin: EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
        ),
      ],
    );
  }
}
