import 'package:flutter/material.dart';
import 'package:notesapp/screen/add_notes_page/add_notes_page_view.dart';

class AddNotePage extends StatefulWidget {
  final String album;
  final String location;
  AddNotePage({
    this.album,
    this.location,
  });
  @override
  AddNotePageView createState() => new AddNotePageView();
}
