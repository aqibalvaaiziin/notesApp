import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import './notes_page.dart';

abstract class NotesPageViewModel extends State<NotesPage> {
  List notes = [];

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

  void toastMsg(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Color(0xff2f3542),
      textColor: Color(0xff2ed573),
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
                    width: (screenSize.width / 1.5) + 30,
                    height: screenSize.height * 0.16,
                    decoration: BoxDecoration(
                      color: Color(0xff404040),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "New Note",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: "F",
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: (screenSize.width / 1.5) + 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: screenSize.width * 0.23,
                                height: screenSize.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Color(0xffffb800),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    child: Center(
                                      child: Text("Drop Note"),
                                    )),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                width: screenSize.width * 0.23,
                                height: screenSize.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Color(0xffffb800),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    child: Center(
                                      child: Text("Add to Album"),
                                    )),
                              ),
                            ],
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
    getNotes();
  }
}
