import 'package:flutter/material.dart';

class AppBarCard extends StatelessWidget {
  AppBarCard({this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: colour,
        ),
      ),
    );
  }
}
