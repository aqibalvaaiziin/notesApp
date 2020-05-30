import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class NotesList extends StatefulWidget {
  final String id;
  final String title;
  final String location;
  final String content;
  final String createdAt;
  final bool isFav;
  final album;

  NotesList({
    this.id,
    this.title,
    this.location,
    this.content,
    this.createdAt,
    this.isFav,
    this.album,
  });

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  var formatter = new DateFormat('dd-MM-yyyy');
  RegExp imageRegex1 = RegExp(r'(?<="source").*(?=}}})', multiLine: true);
  static var start = "source: ";
  var end = "}}}";
  static String contentImage;
  String plaintext;
  String bodyContent;
  String image;
  var doc;
  int type = 0;

  Delta getDelta() {
    return Delta.fromJson(jsonDecode(widget.content) as List);
  }

  void initNoteCard() {
    contentImage = jsonDecode(widget.content).toString();
    doc = NotusDocument.fromDelta(getDelta());
    doc.format(0, 0, NotusAttribute.heading.unset);
    plaintext = doc.toPlainText();
    bodyContent = plaintext.replaceAll("\n", " ");
    var startIndex = contentImage.toString().indexOf(start);
    var endIndex =
        contentImage.toString().indexOf(end, startIndex + start.length);
    if (contentImage.contains('source')) {
      var pattern = contentImage.substring(startIndex + start.length, endIndex);
      if (imageRegex1.stringMatch(contentImage).toString().length > 1) {
        setState(() {
          type = 1;
          image = "$pattern";
        });
      } else if (imageRegex1.stringMatch(contentImage).toString().length < 1) {
        setState(() {
          type = 0;
        });
      }
    } else {
      setState(() {
        type = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initNoteCard();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 1.3,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.189,
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 12,
                                  ),
                                  SizedBox(width: screenSize.width * 0.01),
                                  Text(
                                    widget.location.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.blue),
                                  ),
                                  SizedBox(width: screenSize.width * 0.03),
                                  Icon(
                                    Icons.timer,
                                    color: Colors.blue,
                                    size: 12,
                                  ),
                                  SizedBox(width: screenSize.width * 0.01),
                                  Text(
                                    formatter.format(
                                        DateTime.parse(widget.createdAt)),
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.blue,
                                        letterSpacing: 0.5),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.09,
                  padding: EdgeInsets.only(right: 10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: <Widget>[
                      type == 1
                          ? Expanded(
                              flex: 3,
                              child: Container(
                                height: screenSize.height * 0.08,
                                width: screenSize.width * 0.1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(width: 7),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: screenSize.width,
                              child: Text(
                                widget.title,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "F",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              child: Text(
                                bodyContent,
                                maxLines: 3,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  width: screenSize.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: screenSize.height * 0.028,
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.album == "Not Have a Album"
                              ? Colors.red
                              : Colors.blue,
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
