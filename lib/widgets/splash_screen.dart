import 'package:flutter/material.dart';

splashSreen(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Positioned(
        top: screenSize.height * 0.49,
        left: screenSize.width * 0.3,
        child: Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.2,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
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
              "Dont forget to take your note",
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
