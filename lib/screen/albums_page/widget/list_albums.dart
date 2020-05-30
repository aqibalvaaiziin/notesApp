import 'package:flutter/material.dart';

class AlbumList extends StatefulWidget {
  final String title;
  final int data;

  AlbumList(this.title, this.data);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              child: Image.asset(
                "assets/images/react.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                SizedBox(height: 9),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 16, fontFamily: "CB", letterSpacing: 0.2),
                ),
                SizedBox(height: 3),
                Text(
                  widget.data.toString() + " Notes",
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff0084ff),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
