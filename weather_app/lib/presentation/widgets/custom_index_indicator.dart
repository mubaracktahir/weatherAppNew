import 'package:flutter/material.dart';

class CustomIndexIndicator extends StatelessWidget {
  final Color color;

  const CustomIndexIndicator({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.0,
      height: 14.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: this.color,
      ),
    );
  }
}
