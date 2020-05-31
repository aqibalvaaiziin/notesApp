import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

shimmerNote(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  return Shimmer(
    gradient:
        LinearGradient(colors: [Colors.grey, Colors.grey[350], Colors.grey]),
    child: Container(
        width: screenSize.width,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: screenSize.width * 0.2,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: screenSize.width * 0.2,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: screenSize.height * 0.08,
                    width: screenSize.width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: screenSize.width * 0.3,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: screenSize.width * 0.692,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: screenSize.width * 0.692,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: screenSize.width * 0.25,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  SizedBox(width: 17),
                  Container(
                    width: screenSize.width * 0.25,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ],
              ),
            )
          ],
        )),
  );
}

shimmerAlbums(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  return Shimmer(
    gradient:
        LinearGradient(colors: [Colors.grey, Colors.grey[350], Colors.grey]),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.15,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
          ),
          SizedBox(height: 10),
          Container(
            width: screenSize.width * 0.35,
            height: screenSize.height * 0.02,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          SizedBox(height: 10),
          Container(
            width: screenSize.width * 0.25,
            height: screenSize.height * 0.02,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}
