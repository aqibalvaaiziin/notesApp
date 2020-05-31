import 'package:flutter/material.dart';
import './update_note_page_view.dart';

class UpdateNote extends StatefulWidget {
  final String idNote;
  final String idAlbum;
  final String title;
  final String location;
  final String content;
  final bool isFav;

  UpdateNote(
      {this.idNote,
      this.idAlbum,
      this.title,
      this.location,
      this.content,
      this.isFav});

  @override
  UpdateNoteView createState() => new UpdateNoteView();
}
