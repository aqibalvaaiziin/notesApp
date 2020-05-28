import 'package:flutter/material.dart';
import 'package:notesapp/screen/albums_page/widget/list_albums.dart';
import 'package:notesapp/screen/detail_album_page/detail_album_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:notesapp/widgets/silver_header.dart';
import './albums_page_view_model.dart';

class AlbumsPageView extends AlbumsPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return <Widget>[SilverHeader(name: "All Albums", type: 1)];
          },
          body: albums.length > 0
              ? Container(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: albums
                        .map(
                          (album) => GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(createRoute(DetailAlbum(
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
        ));
  }
}
