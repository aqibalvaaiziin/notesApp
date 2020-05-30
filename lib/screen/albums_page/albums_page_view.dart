import 'package:flutter/material.dart';
import 'package:notesapp/screen/albums_page/widget/list_albums.dart';
import 'package:notesapp/screen/detail_album_page/detail_album_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import './albums_page_view_model.dart';

class AlbumsPageView extends AlbumsPageViewModel {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: isSearch
            ? Container(
                width: screenSize.width,
                height: screenSize.height * 0.1,
                padding: EdgeInsets.fromLTRB(5, 27, 5, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              isSearch = !isSearch;
                            });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      width: screenSize.width * 0.8,
                      child: TextField(
                        style: TextStyle(fontSize: 16, fontFamily: "F"),
                        scrollPadding: EdgeInsets.zero,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusColor: Colors.black,
                          hintText: "Put character here.....",
                          hintStyle: TextStyle(fontSize: 16, fontFamily: "F"),
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                width: screenSize.width,
                height: screenSize.height * 0.1,
                padding: EdgeInsets.fromLTRB(20, 25, 5, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "All Notes",
                        style: TextStyle(fontSize: 22, fontFamily: "F"),
                      ),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              isSearch = !isSearch;
                            });
                          }),
                    ),
                  ],
                ),
              ),
      ),
      body: albums.length > 0
          ? Container(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                children: albums
                    .map(
                      (album) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(createRoute(DetailAlbum(
                            dataId: album['id'],
                            title: album['title'],
                          )));
                        },
                        child: AlbumList(
                          album['title'],
                          album['notes'].length,
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
              backgroundColor: Color(0xff2f3542),
            )),
    );
  }
}
