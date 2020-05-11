import 'dart:convert';

import 'package:app/vo/staff_list_response.dart';
import 'package:dio/dio.dart';

/// 获取网络数据
Future<StaffVOResponse> getHttpStaffData(int pageNumber, int pageSize) async {
  try {
    final String url =
        "http://192.168.0.106:8080/staff/queryByPageStaffVOList?pageNumber=${pageNumber}&pageSize=${pageSize}";
    Response response = await Dio().post(url, data: {"active": true});
    if (response.statusCode == 200) {
      print(response.request.uri);
      String jsonString = response.data;
      final jsonMap = json.decode(jsonString);
      StaffVOResponse staffVOResponse = StaffVOResponse.fromJson(jsonMap);
      return staffVOResponse;
    }
  } catch (e) {
    print(e);
  }
}
