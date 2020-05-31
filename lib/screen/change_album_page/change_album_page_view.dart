import 'package:flutter/material.dart';
import './change_album_page_view_model.dart';

class ChangeAlbumView extends ChangeAlbumViewModel {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                albumValue = null;
                dataValue = null;
              });
            }),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 20),
          width: screenSize.width,
          child: Center(
            child: Text(
              "Change Album Page",
              style: TextStyle(fontSize: 20, fontFamily: "F"),
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: albums.length > 0
              ? ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Card(
                      elevation: 4,
                      child: RadioListTile(
                        value: albums[i],
                        groupValue: albumValue,
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.collections_bookmark),
                            SizedBox(width: 5),
                            Text(
                              albums[i]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "CB",
                              ),
                            ),
                          ],
                        ),
                        activeColor: Color(0xffffb800),
                        subtitle: Text(
                          "Notes : ${albums[i]['notes'].length.toString()}",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff4183f2)),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            setSelectedAlbum(newValue);
                            setSelectedAlbumValue(
                                newValue['id'], newValue['title']);
                          });
                        },
                        selected: albumValue == albums[i]['id'],
                      ),
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff2f3542),
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: dataValue != null
          ? Container(
              margin: EdgeInsets.only(bottom: 10),
              width: screenSize.width * 0.3,
              height: screenSize.width * 0.11,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xffffb800),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: InkWell(
                onTap: () {
                  moveDialog();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      size: 24,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Move",
                      style: TextStyle(fontSize: 19, fontFamily: "CB"),
                    ),
                  ],
                ),
              ))
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
