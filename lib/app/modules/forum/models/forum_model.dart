class Forum {
  String? type;
  int? code;
  List<Info>? info;

  Forum({this.type, this.code, this.info});

  Forum.fromJson(Map<String, dynamic> json) {
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
  int? res;
  String? root;
  int? time;
  int? forum;
  String? name;
  String? cookie;
  dynamic admin;
  String? title;
  String? content;
  dynamic lock;
  List<Images>? images;
  int? replyCount;
  int? hideCount;
  List<Reply>? reply;

  Info(
      {this.id,
      this.res,
      this.root,
      this.time,
      this.forum,
      this.name,
      this.cookie,
      this.admin,
      this.title,
      this.content,
      this.lock,
      this.images,
      this.replyCount,
      this.hideCount,
      this.reply});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    res = json['res'];
    root = json['root'];
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
    replyCount = json['reply_count'];
    hideCount = json['hide_count'];
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply?.add(Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['res'] = res;
    data['root'] = root;
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
    data['reply_count'] = replyCount;
    data['hide_count'] = hideCount;
    if (reply != null) {
      data['reply'] = reply?.map((v) => v.toJson()).toList();
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

class Reply {
  int? id;
  int? res;
  int? time;
  String? name;
  String? cookie;
  dynamic admin;
  String? content;
  List<Images>? images;

  Reply(
      {this.id,
      this.res,
      this.time,
      this.name,
      this.cookie,
      this.admin,
      this.content,
      this.images});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    res = json['res'];
    time = json['time'];
    name = json['name'];
    cookie = json['cookie'];
    admin = json['admin'];
    content = json['content'];
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
    data['name'] = name;
    data['cookie'] = cookie;
    data['admin'] = admin;
    data['content'] = content;
    if (images != null) {
      data['images'] = images?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
