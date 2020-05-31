// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/providers/providers.dart';
import 'package:notesapp/redux/action/main_state_action.dart';
import 'package:notesapp/redux/model/app_state_model.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:redux/redux.dart';
import 'package:zefyr/zefyr.dart';

abstract class AddNotePageViewModel extends State<AddNotePage> {
  Store<AppState> store;
  ZefyrController controller;
  FocusNode focusNode;
  TextEditingController titleController = TextEditingController();

  NotusDocument loadDocument() {
    final Delta delta = Delta()..insert("\n");
    return NotusDocument.fromDelta(delta);
  }

  Future<bool> willPopCallback() async {
    return true;
  }

  Future initNotes() async {
    Providers.getNotes().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      store.dispatch(SetMainState(notes: List.from(data)));
    }).catchError((err) => print(err.toString()));
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
      message("Note Added");
      initNotes();
    });
    Navigator.of(context).push(
      createRoute(HomePage(index: 0)),
    );
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      store = StoreProvider.of<AppState>(context);
    });
  }
}
