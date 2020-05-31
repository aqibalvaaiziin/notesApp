import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import './update_note_page.dart';

abstract class UpdateNoteViewModel extends State<UpdateNote> {
  TextEditingController controllerTitle = TextEditingController();
  ZefyrController controller;
  final FocusNode focusNode = new FocusNode();
  ZefyrMode editing = ZefyrMode.select;

  String dopdownValue = "Edit";
  String plainText;
  int totalWords = 0;
  int totalCharacterSpace = 0;
  int totalCharacterNoSpace = 0;
  int totalLines = 0;
  int totalParagraph = 0;
  bool afterSave;

  Delta getDelta() {
    return Delta.fromJson(jsonDecode(widget.content) as List);
  }

  Future<bool> willPopCallback() async {
    return true;
  }

  btnSave() {
    String newContent = jsonEncode(controller.document);
    Providers.putNote(widget.idNote, widget.idAlbum, controllerTitle.text,
            widget.location, newContent, widget.isFav)
        .then((_) {
      message("Data Updated");
      Navigator.of(context).push(createRoute(HomePage(index: 0)));
    });
  }

  void message(String message) {
    Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void startEditing() {
    setState(() {
      editing = ZefyrMode.edit;
    });
  }

  void stopEditing() {
    setState(() {
      editing = ZefyrMode.select;
    });
  }

  @override
  void initState() {
    super.initState();
    controllerTitle.text = widget.title;
    controller = ZefyrController(NotusDocument.fromDelta(getDelta()));
  }
}
