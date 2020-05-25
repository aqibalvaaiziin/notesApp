import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/screen/home_page/home_page_view_model.dart';

class HomePageView extends HomePageViewModel {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: children[currentIndex]['page'],
      floatingActionButton: CupertinoPopoverButton(
        popoverWidth: screenSize.width / 1.5,
        popoverColor: Color(0xFF2F3542),
        barrierColor: Color(0xFF2F3542).withOpacity(0.4),
        radius: 15,
        child: Container(
          width: screenSize.width * 0.13,
          height: screenSize.width * 0.13,
          decoration: BoxDecoration(
            color: Color(0xffffb800),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Color(0xff757373),
              size: 30,
            ),
          ),
        ),
        popoverBuild: (context) {
          return Container(
            width: screenSize.width / 1.5,
            height: screenSize.height * 0.07,
            color: Color(0xFF2F3542),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.note_add,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      newAlbumDialog();
                    },
                    child: Icon(
                      Icons.create_new_folder,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xff757373),
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: currentIndex,
          backgroundColor: Color(children[currentIndex]['background']),
          selectedItemColor: Color(children[currentIndex]['selectedColor']),
          unselectedItemColor: Color(children[currentIndex]['unSelectedColor']),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.note), title: Container()),
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Container()),
          ],
        ),
      ),
    );
  }
}
