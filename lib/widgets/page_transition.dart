import 'package:flutter/material.dart';

Route createRoute(data) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => data,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeInCubic;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
