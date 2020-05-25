import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesapp/providers/providers.dart';
import './albums_page.dart';

abstract class AlbumsPageViewModel extends State<AlbumsPage> {
  List albums = [];
  List dummy = [];
  Widget image;
  List<Map> dataImage = [
    {
      "name": "flutter",
      "image": "assets/images/flutter.png",
    },
    {
      "name": "angular",
      "image": "assets/images/angular.png",
    },
    {
      "name": "react",
      "image": "assets/images/react.jpg",
    },
    {
      "name": "vue",
      "image": "assets/images/vue.jpeg",
    }
  ];

  void getAlbums() {
    Providers.getAlbums().then((value) {
      List data = jsonDecode(jsonEncode(value.data));
      for (var i = 0; i < data.length; i++) {
        setState(() {
          albums.add(data[i]);
          dummy.add(data[i]);
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
