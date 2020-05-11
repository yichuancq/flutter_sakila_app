import 'dart:convert';

import 'package:app/film/film_list_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

///
Future<String> loadJsonFile() async {
  return await rootBundle.loadString('assets/json/response.json');
}

///获取本地json数据
Future<FilmListResponse> convertFromJson() async {
  String jsonString = await loadJsonFile();
  final jsonMap = json.decode(jsonString);
  FilmListResponse filmListResponse = FilmListResponse.fromJson(jsonMap);
  return filmListResponse;
}

/// 获取网络数据
Future<FilmListResponse> getHttpFilmsData(int pageNumber,int pageSize) async {
  try {
    final String url =
        "http://192.168.0.106:8080/film/queryByPageFilmList?pageNumber=${pageNumber}&pageSize=${pageSize}";
    Response response =
        await Dio().post(url, data: {"rating": "PG", "title": ""});
    if (response.statusCode == 200) {
      print(response.request.uri);
      String jsonString = response.data;
      final jsonMap = json.decode(jsonString);
      FilmListResponse filmListResponse = FilmListResponse.fromJson(jsonMap);
      return filmListResponse;
    }
  } catch (e) {
    print(e);
  }
}
