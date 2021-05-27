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
    with TickerProviderStateMixin {
  AnimationController _splashAnimation;
  AnimationController cloudController;
  AnimationController _backgroundCity;
  AnimationController _foregroundCity;
  AnimationController _fadedBackgroundLeftCloud;
  AnimationController _fadedBackgroundRightCloud;
  Animation<double> cloudAnimation;
  Animation<double> foregroundCityTransition;
  Animation<double> fadeInTransition;

  Animation<RelativeRect> _positionAnimation;
  double _height = 0.0;
  double _width = 0.0;
  VisitPref _visitPref = VisitPref();
  bool splashFlag;

  Future<void> loadVisitFlag() async {
    splashFlag = await _visitPref.getInitialVisitFlag();
    setState(() {});
  }

  @override
  void initState() {
    loadVisitFlag();
    //controllers
    _splashAnimation =
        AnimationController(vsync: this, duration: Duration(seconds: 6))
          ..forward();
    cloudController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _backgroundCity =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _foregroundCity =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _backgroundCity.forward();
            }
          });
    //animations & transitions
    foregroundCityTransition =
        Tween<double>(begin: 0.0, end: 1.0).animate(_foregroundCity);

    fadeInTransition =
        Tween<double>(begin: 0.0, end: 1.0).animate(_backgroundCity);
    cloudAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(cloudController);

    super.initState();
  }

  @override
  void dispose() {
    _splashAnimation.dispose();
    _backgroundCity.dispose();
    cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double bottomDrawable = _size.height / 2;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //background gradient
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

          //background moon
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0.0, _size.height * 0.30, 0.0, 0.0),
              end: RelativeRect.fromLTRB(0.0, _size.height * 0.15, 0.0, 0.0),
            ).animate(_backgroundCity),
            child: FadeTransition(
              opacity: fadeInTransition,
              child: Image(
                width: _size.width,
                image: DrawableImage(
                  'ic_splash_bg_ellipse',
                ),
              ),
            ),
          ),

          //city clip rect vertical animation
          SizeTransition(
            sizeFactor: foregroundCityTransition,
            child: Image(
              image: DrawableImage('ic_splash_bottom_drawable'),
            ),
          ),

          //shadow background city
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0.0, _size.height * 0.30, 0.0, 0.0),
              end: RelativeRect.fromLTRB(0.0, _size.height * 0.25, 0.0, 0.0),
            ).animate(_backgroundCity),
            child: FadeTransition(
              opacity: fadeInTransition,
              child: Image(
                width: _size.width,
                image:
                    DrawableImage('ic_splash_bottom_drawable_shadow_drawable'),
              ),
            ),
          ),

          //cloud
          Positioned(
            bottom: _size.height * 0.5,
            child: FadeTransition(
              opacity: cloudAnimation,
              child: Image(
                width: _size.width / 3.0,
                image: DrawableImage('ic_splash_screen_main_logo', scale: 2.0),
              ),
            ),
          ),

          //left background cloud
          Positioned(
            top: _size.height / 8,
            left: _size.width / 8,
            child: Image(
              width: _size.width / 3.0,
              image: DrawableImage('ic_splash_big_cloud', scale: 2.0),
            ),
          ),
          //right cloud transition
          Positioned(
            top: _size.height / 4,
            right: 0.0,
            child: Image(
              width: _size.width / 3.0,
              image: DrawableImage('ic_splash_small_cloud', scale: 2.0),
            ),
          ),

          //initial explore buttom
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
// ..addStatusListener((status) {
//             if (status == AnimationStatus.completed && splashFlag != true) {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return WeatherScreen();
//               }));
//             }
//           });
