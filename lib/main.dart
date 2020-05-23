import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesapp/providers/providers.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List albums = [];

  getDataAlbums() {
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
    getDataAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("wayahe"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: albums.length,
            itemBuilder: (context, i) => ListTile(
                  title: Text(albums[i]['content']),
                )),
      ),
    );
  }
}
