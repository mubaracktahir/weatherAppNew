import 'package:flutter/material.dart';

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
                      onTap: () {},
                    ),
                    Expanded(
                      child: TextField(
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
