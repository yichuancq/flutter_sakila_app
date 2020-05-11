class CountryResponse {
  int code;
  List<Data> data;
  String msg;
  int totalPage;

  CountryResponse({this.code, this.data, this.msg, this.totalPage});

  CountryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class Data {
  String country;
  int countryId;
  String lastUpdate;

  Data({this.country, this.countryId, this.lastUpdate});

  Data.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryId = json['countryId'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['countryId'] = this.countryId;
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }
}
