import 'package:get/get.dart';

import '../models/forum_list_model.dart';

class ForumListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ForumList.fromJson(map);
      if (map is List)
        return map.map((item) => ForumList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ForumList?> getForumList(int id) async {
    final response = await get('forumlist/$id');
    return response.body;
  }

  Future<Response<ForumList>> postForumList(ForumList forumlist) async =>
      await post('forumlist', forumlist);
  Future<Response> deleteForumList(int id) async =>
      await delete('forumlist/$id');
}
