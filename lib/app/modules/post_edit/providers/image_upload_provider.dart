import 'package:bog_island/app/common/provider/bog_post_connect.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/image_upload_model.dart';

class ImageUploadProvider extends BogPostConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      print(map);
      switch (map['code']) {
        case 301:
          bogSnackBar('${map['code']}', '图片大小超过限制');
          break;
        case 302:
          bogSnackBar('${map['code']}', '图片类型非系统允许的类型');
          break;
        case 303:
          bogSnackBar('${map['code']}', '图片被ban');
          break;
        case 304:
          bogSnackBar('${map['code']}', '没有上传图片	');
          break;
      }
      if (map['code'] == 200) {
        if (map is Map<String, dynamic>) return ImageUpload.fromJson(map);
        if (map is List)
          return map.map((item) => ImageUpload.fromJson(item)).toList();
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> postImageUpload(XFile image) async =>
      await post(
          'upload', MultipartFile(image.readAsBytes(), filename: image.name));
}