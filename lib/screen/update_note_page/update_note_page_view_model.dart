import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/redux/action/main_state_action.dart';
import 'package:notesapp/redux/model/app_state_model.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:redux/redux.dart';
import 'package:zefyr/zefyr.dart';
import './update_note_page.dart';

abstract class UpdateNoteViewModel extends State<UpdateNote> {
  Store<AppState> store;
  TextEditingController controllerTitle = TextEditingController();
  ZefyrController controller;
  final FocusNode focusNode = new FocusNode();
  ZefyrMode editing = ZefyrMode.select;

  Future initNotes() async {
    Providers.getNotes().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      store.dispatch(SetMainState(notes: List.from(data)));
    }).catchError((err) => print(err.toString()));
  }

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      store = StoreProvider.of<AppState>(context);
      await initNotes();
    });
  }
}
