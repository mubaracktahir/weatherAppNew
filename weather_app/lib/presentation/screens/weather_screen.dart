import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/repository/cached_pref.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/weather_search_page.dart';
import 'package:weather_app/presentation/widgets/app_drawer.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_sheet_tile.dart';
import 'package:weather_app/presentation/widgets/custom_index_indicator.dart';
import 'package:weather_app/presentation/widgets/slide_route.dart';
import 'package:weather_app/presentation/widgets/weather_day_tile.dart';
import 'package:weather_app/presentation/widgets/weather_display_tile.dart';
import 'package:weather_app/utils/app_color.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  WeatherData weatherData = WeatherData();
  //List<Weather> weathers;
  ScrollController _controller;
  int _currentIndex = 0;
  bool increaseWeatherTile = false;
  WeatherRepository weatherRepository = WeatherRepository();

  loadWeather() async {
    //weathers = await weatherRepository.getWeatherData();
    //print('${weathers} omom');
  }

  @override
  void initState() {
    //print("Hello0");
    // print(weatherRepository.getWeatherData());
    // Future.delayed(Duration.zero, () async {
    //   weathers = await weatherRepository.getWeatherData();
    // });

    //weathers = weatherData.getWeatherData();
    _controller = ScrollController(initialScrollOffset: 0.0);

    _controller.addListener(() {
      //print('${_controller.offset} offset');
      //print('${_controller.position.maxScrollExtent} maxScrollExtent');
      //print('${_controller.position.minScrollExtent} minScrollExtent');
      if (_controller.offset == _controller.position.minScrollExtent) {
        setState(() {
          _currentIndex = 1;
        });
      }
      if (_controller.offset < _controller.position.maxScrollExtent &&
          _controller.offset > 0.0 &&
          !_controller.position.outOfRange) {
        setState(() {
          _currentIndex = 2;
        });
      }
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          _currentIndex = 3;
        });
      }
    });
    print(increaseWeatherTile);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16.0) + EdgeInsets.only(top: 30.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await CachedPref.clearCachedData();
            bloc.add(LoadWeather());
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  BlocProvider.of<WeatherBloc>(context).add(LoadWeather());
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherError) {
                  return Center(
                    child: Text('Weather Error'),
                  );
                } else if (state is WeatherLoaded) {
                  List<Weather> weathers = state.weatherData;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _openDrawer();
                            },
                            child: Icon(Icons.menu),
                          ),
                          Text(weathers[0].city),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SlideRoute(
                                  page: WeatherSearchScreen(),
                                ),
                              );
                            },
                            child: Icon(Icons.search),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              increaseWeatherTile = !increaseWeatherTile;
                            });
                          },
                          child: WeatherDisplayTile(
                            increaseTile: increaseWeatherTile,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Visibility(
                        visible: !increaseWeatherTile,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, bottom: 10.0),
                                child: Text(
                                  'NEXT 5 DAYS',
                                  style: TextStyle(
                                    //height: 1.2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _size.height * 0.29,
                                child: ListView.builder(
                                  controller: _controller,
                                  padding: EdgeInsets.all(0.0),
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: weathers?.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        showSheet(
                                          context,
                                          weathers[index].color,
                                          weathers[index].day,
                                        );
                                      },
                                      child: WeatherDayTile(
                                        day: weathers[index].day,
                                        //icon: weathers[index].iconUrl,
                                        degree:
                                            '${weathers[index].humidity.toString()}°',
                                        minDegree:
                                            '${weathers[index].mintemperature.toString()}°',
                                        maxDegree:
                                            '${weathers[index].maxtemperature.toString()}°',
                                        color: weathers[index].color,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomIndexIndicator(
                                    color:
                                        _currentIndex == 1 || _currentIndex == 0
                                            ? AppColor.thurColor
                                            : AppColor.fadeWhite,
                                  ),
                                  CustomIndexIndicator(
                                    color: _currentIndex == 2
                                        ? AppColor.thurColor
                                        : AppColor.fadeWhite,
                                  ),
                                  CustomIndexIndicator(
                                    color: _currentIndex == 3
                                        ? AppColor.thurColor
                                        : AppColor.fadeWhite,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

showSheet(BuildContext context, Color color, String day) {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: color,
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
      enableDrag: false,
      context: context,
      builder: (context) {
        return CustomButtomSheetTile(day: day);
      });
}
