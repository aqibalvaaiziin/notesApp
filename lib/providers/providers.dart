import 'package:dio/dio.dart';

class Providers {
  static String url = "https://api-notes-test.herokuapp.com";

  static Future getAlbums() async {
    Dio dio = Dio(); 
    return dio.get("$url/notes");
  }
}
