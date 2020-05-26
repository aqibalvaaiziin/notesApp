import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesapp/providers/providers.dart';
import './albums_page.dart';

abstract class AlbumsPageViewModel extends State<AlbumsPage> {
  List albums = [];

  void getAlbums() {
    Providers.getAlbums().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      for (var i = 0; i < data.length; i++) {
        setState(() {
          albums.add(data[i]);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAlbums();
  }
}
