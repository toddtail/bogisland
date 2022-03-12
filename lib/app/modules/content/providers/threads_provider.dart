import 'package:get/get.dart';

import '../models/threads_model.dart';

class ThreadsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Threads.fromJson(map);
      if (map is List)
        return map.map((item) => Threads.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Threads?> getThreads(int id) async {
    final response = await get('threads/$id');
    return response.body;
  }

  Future<Response<Threads>> postThreads(Threads threads) async =>
      await post('threads', threads);
  Future<Response> deleteThreads(int id) async => await delete('threads/$id');
}
