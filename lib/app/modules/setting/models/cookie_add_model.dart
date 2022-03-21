class CookieAdd {
  String? type;
  int? code;
  List<CookieAddInfo>? info;

  CookieAdd({this.type, this.code, this.info});

  CookieAdd.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    if (json['info'] != null) {
      info = <CookieAddInfo>[];
      json['info'].forEach((v) {
        info?.add(CookieAddInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['code'] = code;
    if (info != null) {
      data['info'] = info?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CookieAddInfo {
  String? cookie;
  dynamic remarks;

  CookieAddInfo({this.cookie, this.remarks});

  CookieAddInfo.fromJson(Map<String, dynamic> json) {
    cookie = json['cookie'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cookie'] = cookie;
    data['remarks'] = remarks;
    return data;
  }
}
