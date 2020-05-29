import 'package:flutter/material.dart';
import 'package:notesapp/screen/notes_page/widget/list_notes.dart';
import './notes_page_view_model.dart';

class NotesPageView extends NotesPageViewModel {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: moreMode ? Color(0xFFff4757) : Color(0xFFFAFAFA),
              centerTitle: false,
              title: Text(
                moreMode ? "${selected.length} selected" : "All Notes",
                style: TextStyle(
                    fontSize: moreMode ? 18 : 24,
                    color: moreMode ? Colors.white : Color(0xFF2F3542),
                    fontWeight: FontWeight.w700,
                    fontFamily: "SFP_Text"),
              ),
              floating: true,
              snap: true,
              actions: <Widget>[
                moreMode
                    ? IconButton(
                        icon: Icon(Icons.book, color: Colors.white),
                        iconSize: 25,
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Icon(Icons.search, color: Color(0xFF2F3542)),
                        iconSize: 25,
                        onPressed: () {},
                      ),
                SizedBox(width: 10),
                moreMode
                    ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        iconSize: 25,
                        onPressed: () {
                          deleteSelectedNote();
                        },
                      )
                    : SizedBox()
              ],
            )
          ];
        },
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: notes.length > 0
                  ? ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notes.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onLongPress: () {
                            if (!checkBox[i]) {
                              selectedCheckbox(i, notes[i].id);
                            }
                          },
                          onTap: () {
                            if (checkBox[i]) {
                              unselectedCheckbox(i, notes[i].id);
                            }
                          },
                          child: Container(
                            color: checkBox.length > 0
                                ? checkBox[i]
                                    ? Color(0xFFdfe4ea)
                                    : Colors.transparent
                                : Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                moreMode ? SizedBox(width: 10) : SizedBox(),
                                moreMode
                                    ? Checkbox(
                                        value: checkBox.length > 0
                                            ? checkBox[i]
                                            : false,
                                        onChanged: (value) {
                                          checkBoxOnChange(
                                              i, value, notes[i].id);
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                        activeColor: Color(0xFFff4757),
                                      )
                                    : Container(),
                                Expanded(
                                    child: NotesList(
                                        id: notes[i]['id'],
                                        title: notes[i]['title'],
                                        location: notes[i]['location'],
                                        content: notes[i]['content'],
                                        createdAt: notes[i]['createdAt'],
                                        isFav: notes[i]['isFav'],
                                        album: notes[i]['album'] != null
                                            ? notes[i]['album']['title']
                                            : "Not Have a Album",
                                        mode: moreMode))
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.7,
                      child: Center(
                        child: Text(
                          "Empty Notes !! ",
                          style: TextStyle(fontSize: 20, fontFamily: "CB"),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
