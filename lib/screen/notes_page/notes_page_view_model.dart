import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import './notes_page.dart';

abstract class NotesPageViewModel extends State<NotesPage> {
  bool moreMode = false;
  List<bool> checkBox = List.generate(2000, (index) => false);
  List<String> selected = List();
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

  void selectedCheckbox(int i, id) {
    setState(() {
      checkBox[i] = true;
      moreMode = checkBox.contains(true) ? true : false;
      selected.contains(id) ? selected.remove(id) : selected.add(id);
    });
  }

  void checkBoxOnChange(int i, value, id) {
    setState(() {
      checkBox[i] = value;
      moreMode = checkBox.contains(true) ? true : false;
      selected.contains(id) ? selected.remove(id) : selected.add(id);
    });
  }

  void unselectedCheckbox(int i, id) {
    setState(() {
      checkBox[i] = false;
      moreMode = checkBox.contains(true) ? true : false;
      selected.contains(id) ? selected.remove(id) : selected.add(id);
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

  Future deleteSelectedNote() {
    showDelete();
    return null;
  }

  void showDelete() {
    showDialog(
      context: context,
      builder: (context) {
        var screenSize = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: Color(0xff23542).withOpacity(0.4),
          body: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  width: (screenSize.width / 1.5) + 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Delete the selected note?"),
                            SizedBox(
                              height: screenSize.height * 0.001,
                            ),
                            Text(
                                "Do you really want to delete it? you can't restore it."),
                            Container(
                              width: (screenSize.width * 1.5) + 30,
                              height: screenSize.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (screenSize.width / 1.5) + 30,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        toastMsg("Delete Successfully");
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
                      width: screenSize.width * 0.1,
                      height: screenSize.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> popCallback() async {
    if (moreMode) {
      setState(() {
        checkBox = List.generate(2000, (i) => false);
        moreMode = checkBox.contains(true) ? true : false;
        selected.clear();
      });
      return false;
    } else
      return true;
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }
}
