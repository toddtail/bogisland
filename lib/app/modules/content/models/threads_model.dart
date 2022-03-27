import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart' show Images;

class Threads {
  String? type;
  int? code;
  ThreadsInfo? info;

  Threads({this.type, this.code, this.info});

  Threads.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    info = json['info'] != null ? ThreadsInfo?.fromJson(json['info']) : null;
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

class ThreadsInfo {
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
  List<ThreadsReply>? reply;

  ThreadsInfo(
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
      this.reply});

  ThreadsInfo.fromJson(Map<String, dynamic> json) {
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
    if (json['reply'] != null) {
      reply = <ThreadsReply>[];
      json['reply'].forEach((v) {
        reply?.add(ThreadsReply.fromJson(v));
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
    if (reply != null) {
      data['reply'] = reply?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Images {
//   String? url;
//   String? ext;

//   Images({this.url, this.ext});

//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     ext = json['ext'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['url'] = url;
//     data['ext'] = ext;
//     return data;
//   }
// }

class ThreadsReply {
  int? id;
  int? res;
  int? time;
  String? name;
  String? cookie;
  dynamic admin;
  String? content;
  List<Images>? images;

  ThreadsReply(
      {this.id,
      this.res,
      this.time,
      this.name,
      this.cookie,
      this.admin,
      this.content,
      this.images});

  ThreadsReply.fromJson(Map<String, dynamic> json,
      {bool isFromTopicInfo = false}) {
    id = json['id'];
    res = json['res'];
    time = json['time'];
    name = json['name'];
    cookie = json['cookie'];
    admin = json['admin'];
    content = json['content'];
    if (isFromTopicInfo) {
      images = json['images'];
    } else {
      if (json['images'] != null) {
        images = <Images>[];
        json['images'].forEach((v) {
          images?.add(Images.fromJson(v));
        });
      }
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
