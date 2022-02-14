import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/cached_pref.dart';
import 'package:weather_app/logic/bloc/weather_bloc/weather_bloc.dart';

class WeatherSearchScreen extends StatefulWidget {
  @override
  _WeatherSearchScreenState createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  var editingController = TextEditingController();
  bool showCancelButton = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(16.0) + EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                width: size.width,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.search),
                      onTap: () async {
                        await CachedPref.clearCachedData();
                        bloc.add(LoadWeather(cityName: editingController.text));
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Rajdhani',
                        ),
                        controller: editingController,
                        decoration: InputDecoration(
                          hintText: 'Start typing to find your location',
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            setState(() {
                              showCancelButton = true;
                            });
                          } else {
                            setState(() {
                              showCancelButton = false;
                            });
                          }
                        },
                        onSubmitted: (val) async {
                          await CachedPref.clearCachedData();
                          bloc.add(LoadWeather(cityName: val));
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    showCancelButton
                        ? GestureDetector(
                            child: Icon(Icons.close),
                            onTap: () {},
                          )
                        : SizedBox(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
