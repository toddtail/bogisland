import 'dart:convert';
import 'package:bog_island/app/common/provider/bog_post_connect.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/image_upload_model.dart';

class ImageUploadProvider extends BogPostConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (value) {
      Map map;
      if (value is String) {
        map = json.decode(value);
        print(map);
      } else if (value is Map) {
        map = value;
      } else {
        map = value as Map;
      }
      Logger().i(map);
      // switch (map['code']) {
      //   case 301:
      //     bogSnackBar('${map['code']}', '图片大小超过限制');
      //     break;
      //   case 302:
      //     bogSnackBar('${map['code']}', '图片类型非系统允许的类型');
      //     break;
      //   case 303:
      //     bogSnackBar('${map['code']}', '图片被ban');
      //     break;
      //   case 304:
      //     bogSnackBar('${map['code']}', '没有上传图片	');
      //     break;
      // }
      if (map['code'] == 200) {
        if (map is Map<String, dynamic>) return ImageUpload.fromJson(map);
        // if (map is List)
        //   return map.map((item) => ImageUpload.fromJson(item)).toList();
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> postImageUpload(List image) async {
    // final imageData = await image.readAsBytes();
    // final imageContentType = 'image/${image.name.split('.')[1]}';
    // final imageName = image.name;

    final imageData = image[0];
    final imageContentType = image[1];
    final imageName = image[2];

    return await post(
      'upload',
      FormData(
        {
          'image': MultipartFile(imageData,
              filename: imageName, contentType: imageContentType)
        },
      ),
      contentType: 'multipart/form-data',
    );
  }
}
