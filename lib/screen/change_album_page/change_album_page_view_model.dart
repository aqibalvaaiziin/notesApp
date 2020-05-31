import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import './change_album_page.dart';

abstract class ChangeAlbumViewModel extends State<ChangeAlbum> {
  Future dataAlbum;
  List albums = [];
  var albumValue;
  String dataValue;
  String albumName;

  setSelectedAlbum(data) {
    setState(() {
      albumValue = data;
    });
  }

  setSelectedAlbumValue(String data, data2) {
    setState(() {
      dataValue = data;
      albumName = data2;
    });
  }

  void message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff00ad00),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future getDataAlbum() async {
    Providers.getAlbums().then((value) {
      List rawData = jsonDecode(jsonEncode(value.data));
      for (var i = 0; i < rawData.length; i++) {
        setState(() {
          albums.add(rawData[i]);
        });
      }
    });
  }

  Future moveDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Color(0xff2f3542).withOpacity(0.4),
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    width: (screenSize.width / 1.5) + 60,
                    height: screenSize.height * 0.224,
                    decoration: BoxDecoration(
                      color: Color(0xff404040),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            "Move this data to $albumName ?",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: "F"),
                          ),
                        ),
                        Container(
                          width: (screenSize.width / 1.5) + 60,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Center(
                            child: Text(
                              "This Note will be move to $albumName album\nand this changed will remove the note from the old album",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: (screenSize.width / 1.5) + 60,
                          height: screenSize.height * 0.055,
                          decoration: BoxDecoration(
                              color: Color(0xffffb800),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                          child: InkWell(
                            onTap: () {
                              Providers.putNote(
                                widget.idNote,
                                dataValue,
                                widget.title,
                                widget.location,
                                widget.content,
                                widget.isFav,
                              ).then((_) {
                                message("Note Updated");
                                Navigator.of(context)
                                    .pushReplacement(createRoute(HomePage(
                                  index: 0,
                                )));
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Accept",
                                  style:
                                      TextStyle(fontSize: 17, fontFamily: "F"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 7,
                    right: 10,
                    child: Container(
                      width: screenSize.width * 0.1,
                      height: screenSize.width * 0.1,
                      decoration: BoxDecoration(
                        color: Color(0xff2f3542),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 17,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getDataAlbum();
  }
}
