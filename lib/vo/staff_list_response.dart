class StaffVOResponse {
  int code;
  List<Data> data;
  String msg;
  int totalPage;

  StaffVOResponse({this.code, this.data, this.msg, this.totalPage});

  StaffVOResponse.fromJson(Map<String, dynamic> json) {
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
  bool active;
  String address;
  int addressId;
  String city;
  int cityId;
  String country;
  int countryId;
  String district;
  String email;
  String firstName;
  String lastName;
  String lastUpdate;
  String phone;
  String picture;
  String postalCode;
  int staffId;

  Data(
      {this.active,
        this.address,
        this.addressId,
        this.city,
        this.cityId,
        this.country,
        this.countryId,
        this.district,
        this.email,
        this.firstName,
        this.lastName,
        this.lastUpdate,
        this.phone,
        this.picture,
        this.postalCode,
        this.staffId});

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    address = json['address'];
    addressId = json['addressId'];
    city = json['city'];
    cityId = json['cityId'];
    country = json['country'];
    countryId = json['countryId'];
    district = json['district'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    lastUpdate = json['lastUpdate'];
    phone = json['phone'];
    picture = json['picture'];
    postalCode = json['postalCode'];
    staffId = json['staffId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['address'] = this.address;
    data['addressId'] = this.addressId;
    data['city'] = this.city;
    data['cityId'] = this.cityId;
    data['country'] = this.country;
    data['countryId'] = this.countryId;
    data['district'] = this.district;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['lastUpdate'] = this.lastUpdate;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    data['postalCode'] = this.postalCode;
    data['staffId'] = this.staffId;
    return data;
  }
}
