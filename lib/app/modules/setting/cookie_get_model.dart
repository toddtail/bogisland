class CookieGet {
  String? type;
  int? code;
  String? info;

  CookieGet({this.type, this.code, this.info});

  CookieGet.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['code'] = code;
    data['info'] = info;
    return data;
  }
}
