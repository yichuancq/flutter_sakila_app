class FilmListResponse {
  int code;
  String msg;
  int totalPage;
  List<Data> data;

  FilmListResponse({this.code, this.msg, this.totalPage, this.data});
  ///
  FilmListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['totalPage'] = this.totalPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int fid;
  String title;
  String category;
  double price;
  int length;
  String rating;
  String description;
  String actors;

  Data(
      {this.fid,
      this.title,
      this.category,
      this.price,
      this.length,
      this.rating,
      this.description,
      this.actors});

  Data.fromJson(Map<String, dynamic> json) {
    fid = json['fid'];
    title = json['title'];
    category = json['category'];
    price = json['price'];
    length = json['length'];
    rating = json['rating'];
    description = json['description'];
    actors = json['actors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fid'] = this.fid;
    data['title'] = this.title;
    data['category'] = this.category;
    data['price'] = this.price;
    data['length'] = this.length;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['actors'] = this.actors;
    return data;
  }
}
