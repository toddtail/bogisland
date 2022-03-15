import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:get/get.dart';

import '../models/threads_model.dart';

class ThreadsProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      print(map);
      if (map is Map<String, dynamic>) return Threads.fromJson(map);
      if (map is List) {
        return map.map((item) => Threads.fromJson(item)).toList();
      }
    };
  }



  Future<Response<dynamic>> postThreads() async {
    FormData data = FormData({
      'id': '15047',
      'page': '1',
      'page_def': '20',
      'order': '0'
    });
    return await post('threads', data);
  }
      
  Future<Response> deleteThreads(int id) async => await delete('threads/$id');
}
