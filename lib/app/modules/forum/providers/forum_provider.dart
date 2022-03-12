import 'package:get/get.dart';

import '../models/forum_model.dart';

class ForumProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Forum.fromJson(map);
      if (map is List) return map.map((item) => Forum.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Forum?> getForum(int id) async {
    final response = await get('forum/$id');
    return response.body;
  }

  Future<Response<Forum>> postForum(Forum forum) async =>
      await post('forum', forum);
  Future<Response> deleteForum(int id) async => await delete('forum/$id');
}
