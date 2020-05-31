import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/redux/action/main_state_action.dart';
import 'package:notesapp/redux/model/app_state_model.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
import 'package:notesapp/screen/change_album_page/change_album_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:redux/redux.dart';
import './detail_album_page.dart';

abstract class DetailAlbumViewModel extends State<DetailAlbum> {
  TextEditingController controller = TextEditingController();
  Store<AppState> store;
  String idNote;
  String idAlbum;
  String titleNote;
  String locationNote;
  String contentNote;
  bool isFavNote;
  List showAlbum = [];
  String albumValue;

  Future putNoteFav() async {
    Providers.putNote(
            idNote, idAlbum, titleNote, locationNote, contentNote, !isFavNote)
        .then((_) async {
      message("Note updated");
      Navigator.of(context).push(createRoute(HomePage(index: 0)));
    });
  }

  Future removeNote() async {
    Providers.deleteNote(idNote).then((_) async {
      message("Note deleted");
      Navigator.of(context).push(createRoute(HomePage(index: 0)));
    });
  }

  void getAlbumById() {
    Providers.getAlbum(widget.dataId).then((value) {
      setState(() {
        showAlbum.add(value.data);
      });
    });
  }

  Future initAlbums() async {
    Providers.getAlbums().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      store.dispatch(SetMainState(albums: List.from(data)));
    }).catchError((err) => print(err.toString()));
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
                                        onPressed: () async {
                                          await removeNote();
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
                                    ? Color(0xfffa920a)
                                    : Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: FlatButton(
                                  onPressed: () {
                                    putNoteFav();
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
                                  initAlbums();
                                });
                                Navigator.of(context).pushReplacement(
                                    createRoute(HomePage(index: 1)));
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      store = StoreProvider.of<AppState>(context);
      await initAlbums();
    });
  }
}
