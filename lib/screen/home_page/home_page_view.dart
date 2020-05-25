import 'package:flutter/material.dart';
import 'package:notesapp/screen/home_page/home_page_view_model.dart';

class HomePageView extends HomePageViewModel {
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: children[currentIndex]['page'],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffffb800),
        child: Icon(
          Icons.add,
          color: Color(0xff2f3542),
          size: 30,
        ),
        onPressed: () {},
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
