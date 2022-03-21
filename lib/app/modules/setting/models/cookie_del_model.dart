class CookieDel {
  String? type;
  int? code;
  String? info;

  CookieDel({this.type, this.code, this.info});

  CookieDel.fromJson(Map<String, dynamic> json) {
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
