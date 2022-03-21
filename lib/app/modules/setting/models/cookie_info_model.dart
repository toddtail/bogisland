import 'package:bog_island/app/modules/setting/models/cookie_add_model.dart';

class CookieInfo {
  String? type;
  int? code;
  Info? info;

  CookieInfo({this.type, this.code, this.info});

  CookieInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    info = json['info'] != null ? Info?.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['code'] = code;
    if (info != null) {
      data['info'] = info?.toJson();
    }
    return data;
  }
}

class Info {
  String? cookie;
  dynamic vip;
  int? sign;
  String? signtime;
  int? point;
  int? exp;
  List<CookieAddInfo>? list;

  Info(
      {this.cookie,
      this.vip,
      this.sign,
      this.signtime,
      this.point,
      this.exp,
      this.list});

  Info.fromJson(Map<String, dynamic> json) {
    cookie = json['cookie'];
    vip = json['vip'];
    sign = json['sign'];
    signtime = json['signtime'];
    point = json['point'];
    exp = json['exp'];
    if (json['list'] != null) {
      list = <CookieAddInfo>[];
      json['list'].forEach((v) {
        list?.add(CookieAddInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cookie'] = cookie;
    data['vip'] = vip;
    data['sign'] = sign;
    data['signtime'] = signtime;
    data['point'] = point;
    data['exp'] = exp;
    if (list != null) {
      data['list'] = list?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}