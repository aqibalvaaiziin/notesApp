import 'package:dio/dio.dart';

class Providers {
  static String url = "https://api-notes-test.herokuapp.com";
  static Dio dio = Dio();

//albums

  static Future getAlbums() async {
    return dio.get("$url/albums");
  }

  static Future getAlbum(String id) async {
    return dio.get("$url/albums/$id");
  }

  static Future postAlbum(String title) async {
    await dio.post("$url/albums", data: {"title": title});
  }

  static Future putAlbum(String albumId, String title) async {
    await dio.put("$url/albums/$albumId", data: {"title": title});
  }

  static Future deleteAlbum(String id) async {
    await dio.delete("$url/albums/$id");
  }

//notes

  static Future getNotes() async {
    return dio.get("$url/notes");
  }

  static Future getNote(String id) async {
    return dio.get("$url/notes/$id");
  }

  static Future postNote(String albumId, String title, String location,
      String content, bool isFav) async {
    await dio.post("$url/notes", data: {
      "album": albumId,
      "title": title,
      "location": location,
      "content": content,
      "isFav": isFav,
    });
  }

  static Future putNote(String noteId, String albumId, String title,
      String location, String content, bool isFav) async {
    await dio.put("$url/notes/$noteId", data: {
      "album": albumId,
      "title": title,
      "location": location,
      "content": content,
      "isFav": isFav,
    });
  }

  static Future deleteNote(String id) async {
    await dio.delete("$url/notes/$id");
  }
}
