// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

abstract class AddNotePageViewModel extends State<AddNotePage> {
  ZefyrController controller;
  FocusNode focusNode;
  TextEditingController titleController = TextEditingController();

  NotusDocument loadDocument() {
    final Delta delta = Delta()..insert("dasdsadsa\n");
    return NotusDocument.fromDelta(delta);
  }

  Future<bool> willPopCallback() async {
    return true;
  }

  message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[800],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  saveNote() {
    var dataContent = jsonEncode(controller.document);
    print("data = ${dataContent.toString()}");
    Providers.postNote(
      widget.album,
      titleController.text,
      widget.location,
      dataContent,
      false,
    ).then((_) {
      controller.document.close();
      titleController.clear();
      Navigator.of(context).pushReplacement(
        createRoute(HomePage(index: 0)),
      );
      message("Note Added");
    });
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    final document = loadDocument();
    controller = ZefyrController(document);
    focusNode = FocusNode();
  }
}
