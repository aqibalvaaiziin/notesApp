import 'package:flutter/material.dart';
import './detail_album_page_view.dart';

class DetailAlbum extends StatefulWidget {
  final String dataId;
  final String title;
  DetailAlbum({this.dataId,this.title});
  @override
  DetailAlbumView createState() => new DetailAlbumView();
}
