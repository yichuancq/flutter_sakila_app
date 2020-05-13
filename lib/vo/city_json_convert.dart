import 'dart:convert';

import 'package:app/vo/city_list_response.dart';
import 'package:dio/dio.dart';

import 'base_config.dart';
/// 获取网络数据
Future<CityResponse> getHttpCityData(
    int pageNumber, int pageSize, int countryId) async {
  try {
    final String url =
        "${baseUrl}/address/queryByPagCityList?pageNumber=${pageNumber}&pageSize=${pageSize}";
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
