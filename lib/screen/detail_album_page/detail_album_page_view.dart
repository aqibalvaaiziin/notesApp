import 'package:fab_menu/fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/screen/notes_page/widget/list_notes.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import './detail_album_page_view_model.dart';

class DetailAlbumView extends DetailAlbumViewModel {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: screenSize.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.257,
                    child: Image.asset(
                      "assets/images/react.png",
                      width: screenSize.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.2,
                      ),
                      Container(
                        width: screenSize.width,
                        child: StickyHeader(
                          header: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              padding:
                                  new EdgeInsets.symmetric(horizontal: 16.0),
                              height: 50.0,
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(
                                        0.0,
                                        5.0,
                                      ),
                                    )
                                  ]),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${controller.text.length == 0 ? widget.title : "N/A"}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xFF2F3542),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "SFP_Text"),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                          highlightColor: Colors.transparent,
                                          iconSize: 20,
                                          icon: Icon(
                                            Icons.search,
                                            color: Color(0xFF2F3542),
                                          ),
                                          onPressed: () {}),
                                      PopupMenuButton<String>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Color(0xFF2F3542),
                                        ),
                                        onSelected: (String newValue) =>
                                            selectedPopupMenu(newValue),
                                        itemBuilder: (BuildContext context) {
                                          return <String>[
                                            'Change Name',
                                            'Delete Album',
                                          ].map((String choice) {
                                            return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(choice));
                                          }).toList();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          content: SingleChildScrollView(
                              child: Container(
                            margin: EdgeInsets.only(
                                bottom: screenSize.height * 0.1),
                            child: showAlbum.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: showAlbum[0]['notes'].length,
                                        itemBuilder: (context, i) => NotesList(
                                              id: showAlbum[0]['notes'][i]
                                                  ['id'],
                                              content: showAlbum[0]['notes'][i]
                                                  ['content'],
                                              title: showAlbum[0]['notes'][i]
                                                  ['title'],
                                              isFav: showAlbum[0]['notes'][i]
                                                  ['isFav'],
                                              createdAt: showAlbum[0]['notes']
                                                  [i]['createdAt'],
                                              location: showAlbum[0]['notes'][i]
                                                  ['location'],
                                              album: showAlbum[0]['title'],
                                              mode: false,
                                            )),
                                  )
                                : Center(
                                    child: Text("Note is not available!"),
                                  ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FabMenu(
        menus: [
          MenuData(
            Icons.note_add,
            (context, menuData) {
              newNoteDialog();
            },
            labelText: "Add new note",
          ),
        ],
        maskColor: Color(0xff2f3542),
        menuButtonBackgroundColor: Color(0xff2f3542),
        menuButtonColor: Colors.white,
        labelBackgroundColor: Color(0xff2f3542),
        labelTextColor: Colors.white,
        mainButtonBackgroundColor: Color(0xffffb800),
      ),
      floatingActionButtonLocation: fabMenuLocation,
    );
  }
}
