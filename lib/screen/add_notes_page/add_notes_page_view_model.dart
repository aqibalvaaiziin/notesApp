import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page.dart';
import 'package:zefyr/zefyr.dart';

abstract class AddNotePageViewModel extends State<AddNotePage> {
  ZefyrController controller;
  TextEditingController titleController = new TextEditingController();
  FocusNode focusNode;
  Timer _debounce;
  StreamSubscription<NotusChange> sub;
  bool sendSaver = false;
  bool saveStatus = false;
  bool outDialog = false;

  bool update = false;
  bool updateStatus = false;

  void initNotes() {
    controller.document
        .format(5, controller.document.length, NotusAttribute.heading.unset);
    controller.document.insert(0, "Write your note here .......");
  }

  Future btnSave() async {
    if (update) {
      if (!updateStatus) {
        // String newContent = jsonEncode(controller.document);
        setState(() {
          updateStatus = true;
        });
        //in here we must update the our data
      } else {
        if (!saveStatus) {
          if (sendSaver) {
            //in here wi will create the note
            setState(() {
              saveStatus = true;
              update = true;
            });
          }
        }
      }
    }
  }

  onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      if (controller.document != null && controller.document.length > 1) {
        if (!saveStatus && !updateStatus) {
          btnSave();
        } else if (saveStatus && !updateStatus) {
          btnSave();
        }
      }
    });
  }

  Future<bool> willPopCallback() async {
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(onSearchChanged);
    controller.dispose();
    focusNode.dispose();
    sub.cancel();
  }

  @override
  void initState() {
    super.initState();
    final document = new NotusDocument();
    controller = new ZefyrController(document);
    focusNode = new FocusNode();
    initNotes();
    controller.addListener(onSearchChanged);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.document.delete(0, controller.document.length - 1);
        setState(() {
          sendSaver = true;
          outDialog = true;
        });
      }
    });
    sub = controller.document.changes.listen((change) {
      setState(() {
        updateStatus = false;
      });
    });
  }
}
