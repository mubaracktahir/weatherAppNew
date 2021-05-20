import 'package:drawable/drawable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/visit_pref.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/utils/app_color.dart';

class WeatherSplash extends StatefulWidget {
  @override
  _WeatherSplashState createState() => _WeatherSplashState();
}

class _WeatherSplashState extends State<WeatherSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  VisitPref _visitPref = VisitPref();
  bool splashFlag;

  Future<void> loadVisitFlag() async {
    splashFlag = await _visitPref.getInitialVisitFlag();
    setState(() {});
  }

  @override
  void initState() {
    loadVisitFlag();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && splashFlag != true) {
              print(splashFlag);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WeatherScreen();
              }));
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: _size.width,
            height: _size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.gradientTop,
                  AppColor.gradientTop,
                  AppColor.gradientBottom
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            bottom: _size.height * 0.15,
            child: Image(
              width: _size.width,
              image: DrawableImage(
                'ic_splash_bg_ellipse',
              ),
            ),
          ),
          Image(
            image: DrawableImage('ic_splash_bottom_drawable'),
          ),
          Positioned(
            bottom: _size.height * 0.25,
            child: Image(
              width: _size.width,
              image: DrawableImage('ic_splash_bottom_drawable_shadow_drawable'),
            ),
          ),
          Positioned(
            bottom: _size.height * 0.5,
            child: Image(
              width: _size.width / 3.0,
              image: DrawableImage('ic_splash_screen_main_logo', scale: 2.0),
            ),
          ),
          Positioned(
            top: _size.height / 4,
            left: _size.width / 8,
            child: Image(
              width: _size.width / 3.0,
              image: DrawableImage('ic_splash_big_cloud', scale: 2.0),
            ),
          ),
          Positioned(
            top: _size.height / 3.5,
            right: 0.0,
            child: Image(
              width: _size.width / 3.0,
              image: DrawableImage('ic_splash_small_cloud', scale: 2.0),
            ),
          ),
          Visibility(
            visible: splashFlag ?? false,
            child: GestureDetector(
              onTap: () {
                _visitPref.setVisitFlag(false);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return WeatherScreen();
                }));
              },
              child: Container(
                width: _size.width,
                height: 50.0,
                margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: Center(
                  child: Text(
                    'EXPLORE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.deepBlue,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
