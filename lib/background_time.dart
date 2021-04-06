import 'package:flutter/material.dart';
import 'dart:io';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DateTime now = new DateTime.now();

    void hour = now.hour.toInt();

    // MORNING

    if (now.hour.toInt() > 3 && now.hour.toInt() < 10) {
      return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Image.asset("assets/images/morning.jpg"),
            child,
          ],
        ),
      );
    }

    // AFTERNOON
    
    else if (now.hour.toInt() > 9 && now.hour.toInt() < 15) {
      return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Image.asset("assets/images/afternoon.jpg"),
            child,
          ],
        ),
      );
    }

    // EVENING
    
    else if (now.hour.toInt() > 14 && now.hour.toInt() < 20) {
      return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Image.asset("assets/images/evening.jpg"),
            child,
          ],
        ),
      );
    }

    // NIGHT

    else if (now.hour.toInt() > 19 && now.hour.toInt() < 25) {
      return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Image.asset("assets/images/night.jpg"),
            child,
          ],
        ),
      );
    }

    // NIGHT 2

    else if (now.hour.toInt() >= 1 && now.hour.toInt() < 4 ) {
      return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Image.asset("assets/images/night.jpg"),
            child,
          ],
        ),
      );
    }

  }
}