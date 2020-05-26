import 'package:flutter/material.dart';

splashSreen(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Positioned(
        top: screenSize.height * 0.4,
        left: screenSize.width * 0.2,
        child: Container(
          width: screenSize.width * 0.5,
          height: screenSize.width * 0.47,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
            )
          ]),
        ),
      ),
      Positioned(
        top: screenSize.height * 0.27,
        left: screenSize.width * 0.02,
        right: screenSize.width * 0.02,
        child: Container(
          child: Image.asset(
            "assets/images/launch.png",
            width: screenSize.height * 0.4,
            height: screenSize.height * 0.4,
          ),
        ),
      ),
      Positioned(
        top: screenSize.height * 0.67,
        child: Container(
          width: screenSize.width,
          child: Center(
            child: Text(
              "NOTE REMINDER",
              style: TextStyle(fontSize: 21, fontFamily: "CB"),
            ),
          ),
        ),
      ),
      Positioned(
        top: screenSize.height * 0.71,
        child: Container(
          width: screenSize.width,
          child: Center(
            child: Text(
              "Forget your pen take this note",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "D",
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
