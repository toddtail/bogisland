class ImageUpload {
  int? code;
  String? pic;
  String? msg;

  ImageUpload({this.code, this.pic, this.msg});

  ImageUpload.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    pic = json['pic'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['pic'] = pic;
    data['msg'] = msg;
    return data;
  }
}
