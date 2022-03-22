import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:get/get.dart';

import '../models/thread_model.dart';

class ThreadProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      switch (map['code']) {
        case 6101:
          bogSnackBar('${map['code']}', 'id不存在');
          break;
        case 6102:
          bogSnackBar('${map['code']}', '没有找到这个内容	');
          break;
      }
      if (map['code'] == 6001) {
        if (map is Map<String, dynamic>) return Thread.fromJson(map);
        if (map is List)
          return map.map((item) => Thread.fromJson(item)).toList();
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> postThread(String id) async =>
      await post('thread', FormData({'id': id}));
}
