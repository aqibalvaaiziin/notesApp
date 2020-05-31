import 'package:flutter/material.dart';
import 'package:notesapp/screen/notes_page/widget/list_notes.dart';
import 'package:notesapp/screen/update_note_page/update_note_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import './notes_page_view_model.dart';

class NotesPageView extends NotesPageViewModel {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                    Container(),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Center(
            child: notes.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: notes.length,
                    itemBuilder: (context, i) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              idNote = notes[i]['id'];
                              idAlbum = notes[i]['album'] == null
                                  ? null
                                  : notes[i]['album']['_id'];
                              titleNote = notes[i]['title'];
                              locationNote = notes[i]['location'];
                              contentNote = notes[i]['content'];
                              isFavNote = notes[i]['isFav'];
                            });
                            Navigator.of(context).push(createRoute(UpdateNote(
                              idNote: idNote,
                              idAlbum: idAlbum,
                              title: titleNote,
                              location: locationNote,
                              content: contentNote,
                              isFav: isFavNote,
                            )));
                          },
                          onLongPress: () {
                            setState(() {
                              idNote = notes[i]['id'];
                              idAlbum = notes[i]['album'] == null
                                  ? null
                                  : notes[i]['album']['_id'];
                              titleNote = notes[i]['title'];
                              locationNote = notes[i]['location'];
                              contentNote = notes[i]['content'];
                              isFavNote = notes[i]['isFav'];
                            });
                            optionDialog();
                          },
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
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.7,
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Color(0xff2f3542),
                    ))),
          ),
        ),
      ),
    );
  }
}
