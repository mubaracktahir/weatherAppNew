import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/internet_bloc/internet_bloc.dart';
import 'package:weather_app/presentation/widgets/customCloudySun.dart';
import 'package:weather_app/presentation/widgets/customLineStroke.dart';
import 'package:weather_app/presentation/widgets/custom_background_cloud.dart';
import 'package:weather_app/presentation/widgets/custom_cross_icon.dart';
import 'package:weather_app/presentation/widgets/custom_line_cross.dart';
import 'package:weather_icons/weather_icons.dart';

class ExamplePaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.greenAccent,
        body: Column(
      children: [
        SizedBox(
          height: 300,
        ),
        Icon(
          WeatherIcons.moon_waning_crescent_3,
          size: 50,
        ),
        WindIcon(degree: 67.62),
        BoxedIcon(
          WeatherIcons.fromString("Rain",
              // Fallback is optional, throws if not found, and not supplied.
              fallback: WeatherIcons.na),
        ),
        BlocBuilder<InternetBloc, InternetState>(
          builder: (context, state) {
            if (state is InternetLoading) {
              BlocProvider.of<InternetBloc>(context).add(InternetConnection());
              return Container(
                color: Colors.blue,
                height: 70,
                width: double.infinity,
              );
            } else if (state is InternetConnected) {
              return Container(
                color: Colors.green,
                height: 70,
                width: double.infinity,
              );
            } else if (state is InternetDisconnected) {
              return Container(
                color: Colors.red,
                height: 70.0,
                width: double.infinity,
              );
            }
            return Container(
              color: Colors.yellow,
            );
          },
        )
      ],
    ));
  }
}
