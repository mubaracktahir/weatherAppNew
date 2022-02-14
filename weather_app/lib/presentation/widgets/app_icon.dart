import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage('assets/images/launch_icon.png')),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}
