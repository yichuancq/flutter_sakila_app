import 'dart:convert';

import 'package:app/address/country_list_response.dart';
import 'package:dio/dio.dart';

/// 获取网络数据
Future<CountryResponse> getHttpCountryData(int pageNumber, int pageSize) async {
  try {
    final String url =
        "http://192.168.0.106:8080/address/queryByPagCountryList?pageNumber=${pageNumber}&pageSize=${pageSize}";
    Response response =
        await Dio().post(url, data: {"rating": "PG", "title": ""});
    if (response.statusCode == 200) {
      print(response.request.uri);
      String jsonString = response.data;
      final jsonMap = json.decode(jsonString);
      CountryResponse filmListResponse = CountryResponse.fromJson(jsonMap);
      return filmListResponse;
    }
  } catch (e) {
    print(e);
  }
}
