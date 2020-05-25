import 'package:flutter/material.dart';
import 'package:notesapp/screen/home_page/home_page_view.dart';

class HomePage extends StatefulWidget {
  final int index;
  HomePage({this.index});
  @override
  HomePageView createState() => new HomePageView();
}
