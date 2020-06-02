import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/model/app_state_model.dart';
import 'package:notesapp/redux/model/main_state_model.dart';
import 'package:notesapp/screen/notes_page/widget/list_notes.dart';
import 'package:notesapp/screen/update_note_page/update_note_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:notesapp/widgets/shimmer.dart';
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
        child: StoreConnector<AppState, MainState>(
          converter: (store) => store.state.mainState,
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Center(
                child: state.notes.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.notes.length,
                        itemBuilder: (context, i) {
                          return Container(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  idNote = state.notes[i]['id'];
                                  idAlbum = state.notes[i]['album'] == null
                                      ? null
                                      : state.notes[i]['album']['_id'];
                                  titleNote = state.notes[i]['title'];
                                  locationNote = state.notes[i]['location'];
                                  contentNote = state.notes[i]['content'];
                                  isFavNote = state.notes[i]['isFav'];
                                });
                                Navigator.of(context)
                                    .push(createRoute(UpdateNote(
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
                                  idNote = state.notes[i]['id'];
                                  idAlbum = state.notes[i]['album'] == null
                                      ? null
                                      : state.notes[i]['album']['_id'];
                                  titleNote = state.notes[i]['title'];
                                  locationNote = state.notes[i]['location'];
                                  contentNote = state.notes[i]['content'];
                                  isFavNote = state.notes[i]['isFav'];
                                });
                                optionDialog();
                              },
                              child: NotesList(
                                id: state.notes[i]['id'],
                                title: state.notes[i]['title'],
                                location: state.notes[i]['location'],
                                content: state.notes[i]['content'],
                                createdAt: state.notes[i]['createdAt'],
                                isFav: state.notes[i]['isFav'],
                                album: state.notes[i]['album'] != null
                                    ? state.notes[i]['album']['title']
                                    : "Not Have a Album",
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            shimmerNote(context),
                            shimmerNote(context),
                            shimmerNote(context),
                            shimmerNote(context),
                            shimmerNote(context),
                            shimmerNote(context),
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
