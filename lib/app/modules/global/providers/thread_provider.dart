import 'package:get/get.dart';

import '../models/thread_model.dart';

class ThreadProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Thread.fromJson(map);
      if (map is List) return map.map((item) => Thread.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Thread?> getThread(int id) async {
    final response = await get('thread/$id');
    return response.body;
  }

  Future<Response<Thread>> postThread(Thread thread) async =>
      await post('thread', thread);
  Future<Response> deleteThread(int id) async => await delete('thread/$id');
}
