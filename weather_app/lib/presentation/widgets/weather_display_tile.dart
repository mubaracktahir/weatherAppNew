import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/customLineStroke.dart';
import 'package:weather_app/presentation/widgets/custom_line_cross.dart';
import 'package:weather_app/utils/app_color.dart';
import './customCloudySun.dart';

class WeatherDisplayTile extends StatefulWidget {
  final int humidity;
  final String description;
  final bool increaseTile;
  final double temperature;

  const WeatherDisplayTile(
      {this.humidity, this.description, this.increaseTile, this.temperature});

  @override
  _WeatherDisplayTileState createState() => _WeatherDisplayTileState();
}

class _WeatherDisplayTileState extends State<WeatherDisplayTile>
    with SingleTickerProviderStateMixin {
  final bool increaseTile;

  _WeatherDisplayTileState({this.increaseTile});

  @override
  void initState() {
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
              widget.increaseTile ? _size.height * 0.80 : _size.height * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppColor.gradientTop,
          ),
          duration: Duration(milliseconds: 300),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.temperature.round()}°",
                style: TextStyle(
                  fontSize: 110.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rajdhani',
                  color: Colors.white,
                ),
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                ),
              ),
              Text(
                'Humidy',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Rajdhani',
                  height: 1.7,
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Text(
                  '${widget.humidity}',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: widget.increaseTile ? 0.0 : _size.width * 0.15,
          top: widget.increaseTile ? _size.height * 0.2 : _size.height * 0.010,
          child: ColorFiltered(
            colorFilter:
                ColorFilter.mode(Colors.transparent, BlendMode.difference),
            child: CustomPaint(
              size: Size(100, 100),
              painter: CustomLineCross(isSmallCross: !widget.increaseTile),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom:
              widget.increaseTile ? _size.height * 0.10 : _size.width * 0.15,
          left: widget.increaseTile ? _size.width * 0.7 : _size.width * 0.05,
          child: CustomPaint(
            size: Size(100, 100),
            painter: CustomLineCross(isSmallCross: !widget.increaseTile),
          ),
        ),
        Positioned(
          top: _size.height * 0.45,
          right: 0.0,
          left: 0.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: widget.increaseTile ? 70 : 0.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomPaint(
              size: Size(300, 70),
              painter: CustomLineStroke(),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: widget.increaseTile
              ? -_size.width * 0.5 * 0.3
              : -_size.width * 0.5 * 0.3,
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
