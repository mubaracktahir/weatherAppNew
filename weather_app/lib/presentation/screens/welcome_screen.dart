import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  Color _backgroundColor = Color(0xff0051ff);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Container(
        child: Column(
          children: [
            Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              height: 50.0,
              margin: EdgeInsets.only(right: 40.0, left: 40.0, bottom: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Center(
                child: Text(
                  'EXPLORE',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
