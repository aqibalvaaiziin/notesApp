import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesList extends StatefulWidget {
  final String id;
  final String title;
  final String location;
  final String content;
  final String createdAt;
  final bool isFav;
  final album;
  final bool mode;

  NotesList(this.id, this.title, this.location, this.content, this.createdAt,
      this.isFav, this.album, this.mode);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  var formatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 1.3,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.17,
        margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.03,
          vertical: screenSize.height * 0.01,
        ),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: screenSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.45,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          style: TextStyle(fontFamily: "F",fontSize: 15),
                        ),
                      ),
                       Container(
                              width: widget.mode ? 0 : screenSize.width * 0.43,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                  SizedBox(width: screenSize.width * 0.01),
                                  Text(
                                    widget.location.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                  SizedBox(width: screenSize.width * 0.03),
                                  Icon(
                                    Icons.timer,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                  SizedBox(width: screenSize.width * 0.01),
                                  Text(
                                    formatter.format(
                                        DateTime.parse(widget.createdAt)),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue,letterSpacing: 0.5),
                                  ),
                                ],
                              ),
                            )
                        
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.053,
                  padding: EdgeInsets.only(right: 10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    widget.content,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: screenSize.height * 0.028,
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.bookmark,
                              size: 13,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: screenSize.width * 0.02,
                            ),
                            Text(
                              widget.album,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      widget.isFav
                          ? Container(
                              width: screenSize.width * 0.25,
                              height: screenSize.height * 0.028,
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color(0xff10bf0a),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.02,
                                  ),
                                  Text(
                                    "Favourite",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
