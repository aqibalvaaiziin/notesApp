import 'package:flutter/material.dart';
import './change_album_page_view.dart';

class ChangeAlbum extends StatefulWidget {
  final String idNote;
  final String title;
  final String location;
  final String content;
  final bool isFav;

  ChangeAlbum(
      {this.idNote, this.title, this.location, this.content, this.isFav});

  @override
  ChangeAlbumView createState() => new ChangeAlbumView();
}
