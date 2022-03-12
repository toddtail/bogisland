class Thread {
  String? type;
  int? code;
  Info? info;

  Thread({this.type, this.code, this.info});

  Thread.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? res;
  int? time;
  int? forum;
  String? name;
  String? cookie;
  dynamic admin;
  String? title;
  String? content;
  dynamic lock;
  List<Images>? images;

  Info(
      {this.id,
      this.res,
      this.time,
      this.forum,
      this.name,
      this.cookie,
      this.admin,
      this.title,
      this.content,
      this.lock,
      this.images});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    res = json['res'];
    time = json['time'];
    forum = json['forum'];
    name = json['name'];
    cookie = json['cookie'];
    admin = json['admin'];
    title = json['title'];
    content = json['content'];
    lock = json['lock'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['res'] = res;
    data['time'] = time;
    data['forum'] = forum;
    data['name'] = name;
    data['cookie'] = cookie;
    data['admin'] = admin;
    data['title'] = title;
    data['content'] = content;
    data['lock'] = lock;
    if (images != null) {
      data['images'] = images?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? url;
  String? ext;

  Images({this.url, this.ext});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    ext = json['ext'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['ext'] = ext;
    return data;
  }
}
