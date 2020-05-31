import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/redux/action/main_state_action.dart';
import 'package:notesapp/redux/model/app_state_model.dart';
import 'package:notesapp/redux/model/main_state_model.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
import 'package:notesapp/screen/albums_page/albums_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/screen/notes_page/notes_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:redux/redux.dart';

abstract class HomePageViewModel extends State<HomePage> {
  int currentIndex = 0;
  TextEditingController controller = TextEditingController();
  Store<AppState> store;
  String albumValue;
  bool isSuccess = true;

  List<Map> children = [
    {
      "name": "All Notes",
      "page": NotesPage(),
      "unSelectedColor": 0xffa4b0be,
      "selectedColor": 0xffffb800,
      "background": 0xff2f3542
    },
    {
      "name": "All Albums",
      "page": AlbumsPage(),
      "unSelectedColor": 0xffa4b0be,
      "selectedColor": 0xffffb800,
      "background": 0xff2f3542
    },
  ];

  Future initAlbums() async {
    Providers.getAlbums().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      store.dispatch(SetMainState(albums: List.from(data)));
    }).catchError((err) => print(err.toString()));
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future newAlbum() async {
    if (controller.text.isNotEmpty) {
      Providers.postAlbum(controller.text).then((_) {
        setState(() {
          isSuccess = false;
        });
        message("Album Added");
        initAlbums();
      });
      Navigator.of(context).pushReplacement(createRoute(HomePage(index: 1)));
    } else {
      setState(() {
        isSuccess = true;
        message("Add The Title");
      });
    }
  }

  void message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isSuccess ? Colors.red : Color(0xff00ad00),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future newAlbumDialog() async {
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
                    height: screenSize.height * 0.239,
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
                                "New Album",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "F",
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type the new album title.... ",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
                                newAlbum();
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

  Future newNoteDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Color(0xff2f3542).withOpacity(0.4),
            body: StoreConnector<AppState, MainState>(
              converter: (store) => store.state.mainState,
              builder: (context, state) {
                return Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(15),
                        width: (screenSize.width / 1.5) + 30,
                        height: screenSize.height * 0.29,
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
                                      width: screenSize.width * 0.7,
                                      padding: EdgeInsets.only(top: 10),
                                      child: state.albums.length > 0
                                          ? DropdownButton(
                                              iconSize: 0,
                                              focusColor: Colors.white,
                                              dropdownColor: Color(0xff404040),
                                              hint: Text(
                                                "Choose the album you have",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                              value: albumValue,
                                              items: state.albums.map((album) {
                                                return new DropdownMenuItem(
                                                  value: album['id'],
                                                  child: Text(
                                                    album['title'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (data) {
                                                albumValue = data;
                                                setState(() {});
                                              },
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )),
                                  Container(
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
                                    if (controller.text.isEmpty) {
                                      setState(() {
                                        isSuccess = true;
                                        message("Add the form first!");
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .push(createRoute(AddNotePage(
                                        location: controller.text,
                                        album: albumValue,
                                      )));
                                      controller.clear();
                                      albumValue = null;
                                    }
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
                );
              },
            ),
          );
        });
  }

  @override
  void initState() {
    currentIndex = this.widget.index ?? 0;
    super.initState();
    initAlbums();
  }
}
