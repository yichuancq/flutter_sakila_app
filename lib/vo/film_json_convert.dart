import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:app/film/film_list_response.dart';

///解析站点JSON为对象集合
Future<String> loadJsonFile() async {
  return await rootBundle.loadString('assets/json/response.json');
}

///convertFromAlbumJson
Future<FilmListResponse> convertFromJson() async {
  String jsonString = await loadJsonFile();
  final jsonMap = json.decode(jsonString);
  FilmListResponse filmListResponse = FilmListResponse.fromJson(jsonMap);
  return filmListResponse;
}
