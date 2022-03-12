class PostContent {
  String? type;
  int? code;
  int? info;

  PostContent({this.type, this.code, this.info});

  PostContent.fromJson(Map<String, dynamic> json) {
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
