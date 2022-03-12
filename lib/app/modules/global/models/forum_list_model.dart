class ForumList {
  String? type;
  int? code;
  List<Info>? info;

  ForumList({this.type, this.code, this.info});

  ForumList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info?.add(Info.fromJson(v));
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

class Info {
  int? id;
  String? name;
  String? name2;
  String? headimg;
  String? info;

  Info({this.id, this.name, this.name2, this.headimg, this.info});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name2 = json['name2'];
    headimg = json['headimg'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name2'] = name2;
    data['headimg'] = headimg;
    data['info'] = info;
    return data;
  }
}
