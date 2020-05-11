import 'dart:convert';

import 'package:app/address/city_list_response.dart';
import 'package:dio/dio.dart';

/// 获取网络数据
Future<CityResponse> getHttpCityData(
    int pageNumber, int pageSize, int countryId) async {
  try {
    final String url =
        "http://192.168.0.106:8080/address/queryByPagCityList?pageNumber=${pageNumber}&pageSize=${pageSize}";
    Response response =
        await Dio().post(url, data: {"countryId": "${countryId}"});
    if (response.statusCode == 200) {
      print(response.request.uri);
      String jsonString = response.data;
      final jsonMap = json.decode(jsonString);
      CityResponse filmListResponse = CityResponse.fromJson(jsonMap);
      return filmListResponse;
    }
  } catch (e) {
    print(e);
  }
}
