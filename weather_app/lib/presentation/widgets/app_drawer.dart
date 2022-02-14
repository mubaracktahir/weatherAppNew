import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_color.dart';

import 'app_icon.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 70.0),
      color: Colors.white,
      width: _size.width * 0.65,
      child: Column(
        children: [
          AppIcon(),
          SizedBox(height: 10),
          Text(
            'WeatherApp',
            style: TextStyle(
              color: AppColor.deepBlue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 12.0),
            width: double.maxFinite,
            height: 40,
            color: AppColor.backgroundDesign,
            alignment: Alignment.centerLeft,
            child: Text(
              'Dashboard',
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(thickness: 2.0),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(left: 12.0),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationVersion: '1.0.0',
                  applicationName: 'WeatherApp',
                  applicationLegalese:
                      'An app that gets weather forecast worldwide using device location and search by country/city name.',
                  applicationIcon: AppIcon(),
                );
              },
              child: Text(
                'About App',
                style: TextStyle(
                    color: AppColor.deepBlue, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
