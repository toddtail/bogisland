import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:get/get.dart';

import '../models/threads_model.dart';

class ThreadsProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      // print(map);
      if(map['info'] == 'error') {
        return map as Map;
      }
      if (map is Map<String, dynamic>) return Threads.fromJson(map);
      if (map is List) {
        return map.map((item) => Threads.fromJson(item)).toList();
      }
    };
  }

  Future<Response<dynamic>> postThreads(int id, int page) async {
    FormData data = FormData({
      'id': '$id',
      'page': '$page',
      'page_def': '20',
      'order': '0'
    });
    return await post('threads', data);
  }
}
