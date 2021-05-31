import 'package:flutter/material.dart';
import './customCloudySun.dart';

class WeatherDisplayTile extends StatefulWidget {
  final bool increaseTile;

  const WeatherDisplayTile({Key key, this.increaseTile}) : super(key: key);

  @override
  _WeatherDisplayTileState createState() => _WeatherDisplayTileState();
}

class _WeatherDisplayTileState extends State<WeatherDisplayTile>
    with SingleTickerProviderStateMixin {
  final bool increaseTile;
  AnimationController _position;
  bool _positionFlag = false;

  _WeatherDisplayTileState({this.increaseTile});

  @override
  void initState() {
    _position =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      //clipBehavior: Clip.none,
      //alignment: Alignment.bottomCenter,
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(bottom: 5.0),
          width: double.infinity,
          height:
              widget.increaseTile ? _size.height * 0.80 : _size.height * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: Colors.purpleAccent,
          ),
          duration: Duration(milliseconds: 200),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
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
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: widget.increaseTile
              ? -_size.width * 0.5 * 0.3
              : -_size.width * 0.5 * 0.4,
          right: widget.increaseTile
              ? _size.width * 0.4
              : -_size.width * 0.5 * 0.2,
          left: widget.increaseTile
              ? -_size.width * 0.5 * 0.2
              : _size.width * 0.5,
          child: CustomPaint(
            size: Size(_size.width * 0.5, _size.width * 0.5),
            painter: CustomCloudySun(isSmallSun: widget.increaseTile),
          ),
        )
      ],
    );
  }
}
