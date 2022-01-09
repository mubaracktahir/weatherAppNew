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
  AnimationController _cloudController;
  AnimationController _backgroundCityController;
  AnimationController _foregroundCityController;
  Animation<double> cloudAnimation;
  Animation<double> foregroundCityTransition;
  Animation<double> fadeInTransition;

  VisitPref _visitPref = VisitPref();
  bool splashFlag = true;
  bool _onFadeOnbackgroundFlag = false;
  bool _onFinishedCloubdTransition = false;

  Future<void> loadVisitFlag() async {
    splashFlag = await _visitPref.getInitialVisitFlag();
    setState(() {});
  }

  void navigationControl() {
    _foregroundCityController.reverseDuration = Duration(milliseconds: 100);
    _foregroundCityController.reverse();
    _foregroundCityController.addListener(() {
      if (_foregroundCityController.isDismissed) {
        _backgroundCityController.reverseDuration = Duration(milliseconds: 250);
        _backgroundCityController.reverse();
        _backgroundCityController.addListener(() {
          if (_backgroundCityController.isDismissed) {
            setState(() {
              _onFinishedCloubdTransition = true;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    loadVisitFlag();
    //controllers
    _cloudController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _backgroundCityController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _foregroundCityController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _backgroundCityController.forward();
            }
          });
    _backgroundCityController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _onFadeOnbackgroundFlag = true;
        });
      }
    });
    _cloudController.addStatusListener((status) {
      if (status == AnimationStatus.completed && splashFlag == false) {
        navigationControl();
      }
    });
    //animations & transitions
    foregroundCityTransition =
        Tween<double>(begin: 0.0, end: 1.0).animate(_foregroundCityController);

    fadeInTransition =
        Tween<double>(begin: 0.0, end: 1.0).animate(_backgroundCityController);
    cloudAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_cloudController);

    super.initState();
  }

  @override
  void dispose() {
    _foregroundCityController.dispose();
    _backgroundCityController.dispose();
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
            ).animate(_backgroundCityController),
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
            ).animate(_backgroundCityController),
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
          TweenAnimationBuilder(
            tween: Tween<double>(
              begin: -_size.width / 3.0,
              end: _onFadeOnbackgroundFlag
                  ? _onFinishedCloubdTransition
                      ? _size.width + _size.width / 3
                      : _size.width / 8
                  : -_size.width / 3.0,
            ),
            onEnd: () {
              if (_onFadeOnbackgroundFlag && !_onFinishedCloubdTransition) {
                _cloudController.forward();
              }
              if (_onFinishedCloubdTransition) {
                _cloudController.reverseDuration = Duration(milliseconds: 300);
                _cloudController.reverse();
                _cloudController.addListener(() {
                  if (_cloudController.isDismissed && splashFlag != true) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return WeatherScreen();
                    }));
                  }
                });
              }
            },
            duration: _onFinishedCloubdTransition
                ? Duration(milliseconds: 200)
                : Duration(seconds: 2),
            builder: (_, value, __) {
              return Positioned(
                top: _size.height / 8,
                left: value,
                child: Image(
                  width: _size.width / 3.0,
                  image: DrawableImage('ic_splash_big_cloud', scale: 2.0),
                ),
              );
            },
          ),

          //right cloud transition
          TweenAnimationBuilder(
            tween: Tween<double>(
              begin: -_size.width / 3.0,
              end: _onFadeOnbackgroundFlag
                  ? _onFinishedCloubdTransition
                      ? _size.width + _size.width / 20
                      : _size.width / 8
                  : -_size.width / 3.0,
            ),
            duration: _onFinishedCloubdTransition
                ? Duration(milliseconds: 200)
                : Duration(seconds: 2),
            builder: (_, value, __) {
              return Positioned(
                top: _size.height / 4,
                right: value,
                child: Image(
                  width: _size.width / 3.0,
                  image: DrawableImage('ic_splash_small_cloud', scale: 2.0),
                ),
              );
            },
          ),

          //initial explore buttom
          Visibility(
            visible: splashFlag,
            child: GestureDetector(
              onTap: () {
                _visitPref.setVisitFlag(false);
                setState(() {
                  splashFlag = false;
                  navigationControl();
                });
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
