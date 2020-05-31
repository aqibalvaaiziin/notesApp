import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import './detail_album_page.dart';

abstract class DetailAlbumViewModel extends State<DetailAlbum> {
  TextEditingController controller = TextEditingController();
  List albums = [];
  List showAlbum = [];
  String albumValue;

  void getAlbumById() {
    Providers.getAlbum(widget.dataId).then((value) {
      setState(() {
        showAlbum.add(value.data);
      });
    });
  }

  void getAlbums() {
    Providers.getAlbums().then((value) {
      List rawData = jsonDecode(jsonEncode(value.data));
      for (var i = 0; i < rawData.length; i++) {
        setState(() {
          albums.add(rawData[i]);
        });
      }
    });
  }

  Future selectedPopupMenu(String value) async {
    switch (value) {
      case "Change Name":
        changeNameDialog();
        break;
      case "Delete Album":
        deleteDialog();
        break;
      default:
    }
  }

  message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future deleteDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final screenSize = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Color(0xFF2F3542).withOpacity(0.4),
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    width: (screenSize.width / 1.5) + 30,
                    constraints: BoxConstraints(maxHeight: 165),
                    decoration: BoxDecoration(
                        color: Color(0xFFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Delete this album?",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF2F3542),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "SFP_Text"),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Do you really want to delete these records? This process cannot be undone.",
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: (screenSize.width / 1.5) + 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Container(
                            width: (screenSize.width / 1.5) + 30,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Providers.deleteAlbum(widget.dataId).then((_) {
                                  message("Data Deleted");
                                  Navigator.of(context)
                                      .pushReplacement(createRoute(HomePage(
                                    index: 1,
                                  )));
                                });
                                setState(() {});
                              },
                              child: Center(
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF2F3542),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Center(
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future changeNameDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final screenSize = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Color(0xFF2F3542).withOpacity(0.4),
            body: Center(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15),
                      width: (screenSize.width / 1.5) + 30,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFFF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Change Name",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF2F3542),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "F"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF2F3542),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "D"),
                                    autofocus: true,
                                    controller: controller,
                                    decoration: InputDecoration(
                                      hintText: "Change name album...",
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF2F3542),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "D"),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: (screenSize.width / 1.5) + 30,
                            decoration: BoxDecoration(
                                color: Color(0xFF2ED573),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Providers.putAlbum(
                                        widget.dataId, controller.text)
                                    .then((_) {
                                  message("Title updated");
                                  controller.clear();
                                  Navigator.of(context).pushReplacement(
                                      createRoute(HomePage(index: 1,)));
                                });
                                setState(() {});
                              },
                              child: Center(
                                child: Icon(
                                  Icons.update,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF2F3542),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future newNoteDialog() async {
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
                    height: screenSize.height * 0.22,
                    decoration: BoxDecoration(
                      color: Color(0xff404040),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add your location....",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (screenSize.width / 1.5) + 30,
                          height: screenSize.height * 0.07,
                          decoration: BoxDecoration(
                            color: Color(0xffffb800),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .push(createRoute(AddNotePage(
                                  album: widget.dataId,
                                  location: controller.text,
                                )));
                              },
                              child: Center(
                                child: Icon(Icons.add, color: Colors.white),
                              )),
                        )
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
                              controller.clear();
                              albumValue = null;
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
    getAlbumById();
    getAlbums();
  }
}
