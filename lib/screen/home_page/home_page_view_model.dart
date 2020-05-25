import 'package:flutter/material.dart';
import 'package:notesapp/screen/albums_page/albums_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/screen/notes_page/notes_page.dart';

abstract class HomePageViewModel extends State<HomePage> {
  int currentIndex = 0;
  List<Map> children = [
    {
      "name": "All Notes",
      "page": NotesPage(),
      "unSelectedColor": 0xffa4b0be,
      "selectedColor": 0xffffb800,
      "background": 0xff2f3542
    },
    {
      "name": "All Albums",
      "page": AlbumsPage(),
      "unSelectedColor": 0xFFa4b0be,
      "selectedColor": 0xffffb800,
      "background": 0xFF2F3542
    },
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    currentIndex = this.widget.index ?? 0;
    super.initState();
  }
}
