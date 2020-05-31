import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/screen/change_album_page/change_album_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import './notes_page.dart';

abstract class NotesPageViewModel extends State<NotesPage> {
  List notes = [];
  String idNote;
  String idAlbum;
  String titleNote;
  String locationNote;
  String contentNote;
  bool isFavNote;

  void getNotes() {
    Providers.getNotes().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      for (var i = 0; i < data.length; i++) {
        setState(() {
          notes.add(data[i]);
        });
      }
    });
  }

  void message(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  Future optionDialog() async {
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
                    height: screenSize.height * 0.234,
                    decoration: BoxDecoration(
                      color: Color(0xff404040),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Container(
                              child: Center(
                                child: Text(
                                  "Note Options",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "CB",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .push(createRoute(ChangeAlbum(
                                            idNote: idNote,
                                            title: titleNote,
                                            location: locationNote,
                                            content: contentNote,
                                            isFav: isFavNote,
                                          )));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.playlist_add,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Add to album",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "FL",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  letterSpacing: 0.9),
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red[700],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: FlatButton(
                                        onPressed: () {
                                          Providers.deleteNote(idNote)
                                              .then((_) {
                                            message("Note deleted");
                                            Navigator.of(context)
                                                .pushReplacement(
                                              createRoute(HomePage(index: 0)),
                                            );
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Delete note",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "FL",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  letterSpacing: 0.9),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: isFavNote
                                  ? screenSize.width * 0.43
                                  : screenSize.width * 0.35,
                              decoration: BoxDecoration(
                                color: isFavNote
                                    ? Colors.orange[700]
                                    : Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: FlatButton(
                                  onPressed: () {
                                    Providers.putNote(
                                            idNote,
                                            idAlbum,
                                            titleNote,
                                            locationNote,
                                            contentNote,
                                            !isFavNote)
                                        .then((_) {
                                      message("Note updated");
                                      Navigator.of(context)
                                          .pushReplacement(createRoute(HomePage(
                                        index: 0,
                                      )));
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        isFavNote
                                            ? Icons.close
                                            : Icons.check_box,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        isFavNote
                                            ? "Remove from favourite"
                                            : "Add to favourite",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "FL",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            letterSpacing: 0.9),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
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
    getNotes();
  }
}
