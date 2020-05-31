import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page_view_model.dart';
import 'package:zefyr/zefyr.dart';

class AddNotePageView extends AddNotePageViewModel {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var formatter = DateFormat('dd-MM-yyyy');
    String date = formatter.format(DateTime.now());
    final theme = new ZefyrThemeData(
        attributeTheme: AttributeTheme(
            heading1: LineTheme(
                textStyle: TextStyle(fontSize: 30),
                padding: EdgeInsets.all(5))),
        toolbarTheme: ToolbarTheme.fallback(context).copyWith(
          color: Color(0xFF2f3542),
          toggleColor: Colors.grey.shade900,
          iconColor: Colors.white,
          disabledIconColor: Colors.grey.shade500,
        ));

    return WillPopScope(
      onWillPop: () => willPopCallback(),
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.timer,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "F",
                  color: Colors.blue,
                ),
              )
            ],
          ),
          actions: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                saveNote();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: ZefyrScaffold(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Column(
              children: <Widget>[
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "F",
                    color: Color(0xff2f3542),
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      alignLabelWithHint: true,
                      hintText: "Title",
                      hintStyle: TextStyle(
                          fontSize: 22, fontFamily: "F", color: Colors.grey)),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    width: screenSize.width * 0.95,
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: ZefyrTheme(
                    data: theme,
                    child: ZefyrEditor(
                      controller: controller,
                      focusNode: focusNode,
                      autofocus: false,
                      imageDelegate:new MyAppZefyrImageDelegate(),
                      physics: ClampingScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker().getImage(source: source);
    if (file == null) return null;
    return file.path;
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    final file = File.fromUri(Uri.parse(key));
    final image = FileImage(file);
    return Image(image: image);
  }
}
