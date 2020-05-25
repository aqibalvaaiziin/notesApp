import 'package:flutter/material.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/screen/notes_page/widget/list_notes.dart';
import 'package:notesapp/widgets/page_transition.dart';
import './notes_page_view_model.dart';

class NotesPageView extends NotesPageViewModel {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: moreMode ? Color(0xFFff4757) : Color(0xfffafafa),
              centerTitle: false,
              title: Text(
                moreMode ? "${selected.length} selected" : "All Notes",
                style: TextStyle(
                  fontSize: moreMode ? 18 : 24,
                  fontFamily: "CB",
                  color: Color(0xff2f3542),
                ),
              ),
              floating: true,
              snap: true,
              actions: <Widget>[
                moreMode
                    ? IconButton(
                        icon: Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        iconSize: 25,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            createRoute(HomePage()),
                          );
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Color(0xff2f3542),
                        ),
                        iconSize: 25,
                        onPressed: () {},
                      ),
                SizedBox(width: 10),
                moreMode
                    ? IconButton(icon: Icon(Icons.delete), onPressed: () {})
                    : SizedBox()
              ],
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: screenSize.height,
              child: notes.length != 0
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notes.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onLongPress: () {
                            if (!checkbox[i])
                              selectedCheckbox(i, notes[i]['id']);
                          },
                          onTap: () {
                            if (checkbox[i])
                              unselectedCheckBox(i, notes[i]['id']);
                          },
                          child: Container(
                            color: checkbox.length > 0
                                ? checkbox[i]
                                    ? Color(0xffdfe4ea)
                                    : Colors.transparent
                                : Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                moreMode
                                    ? SizedBox(
                                        width: 10,
                                      )
                                    : SizedBox(),
                                moreMode
                                    ? Checkbox(
                                        value: checkbox.length > 0
                                            ? checkbox[i]
                                            : false,
                                        onChanged: (value) {
                                          checkBoxOnChange(
                                              i, value, notes[i]['id']);
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                        activeColor: Color(0xffff4757),
                                      )
                                    : Container(),
                                Expanded(
                                    child: NotesList(
                                        notes[i]['id'],
                                        notes[i]['title'],
                                        notes[i]['location'],
                                        notes[i]['content'],
                                        notes[i]['createdAt'],
                                        notes[i]['isFav'],
                                        notes[i]['album']['title'],
                                        moreMode)),
                              ],
                            ),
                          ),
                        );
                      })
                  : Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.4),
                      width: screenSize.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xff2f3542),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
