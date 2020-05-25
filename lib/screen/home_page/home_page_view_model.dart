import 'package:flutter/material.dart';
import 'package:notesapp/screen/albums_page/albums_page.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/screen/notes_page/notes_page.dart';

abstract class HomePageViewModel extends State<HomePage> {
  int currentIndex = 0;
  TextEditingController controller = TextEditingController();
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

  Future newAlbumDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Color(0xff2f3542).withOpacity(0.4),
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    width: (screenSize.width / 1.5) + 30,
                    height: screenSize.height * 0.2448,
                    decoration: BoxDecoration(
                      color: Color(0xff404040),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "New Album",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "F",
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type the new album title.... ",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (screenSize.width / 1.5) + 30,
                          height: screenSize.height * 0.07,
                          decoration: BoxDecoration(
                            color: Color(0xff2ed573),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Center(
                                child: Icon(Icons.add, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 7,
                    right: 10,
                    child: Container(
                      width: screenSize.width * 0.08,
                      height: screenSize.width * 0.08,
                      decoration: BoxDecoration(
                        color: Color(0xff2f3542),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 17,
                            ),
                            onPressed: () => Navigator.of(context).pop()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    currentIndex = this.widget.index ?? 0;
    super.initState();
  }
}
