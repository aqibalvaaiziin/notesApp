// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
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
