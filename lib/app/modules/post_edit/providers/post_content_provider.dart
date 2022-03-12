import 'package:get/get.dart';

import '../models/post_content_model.dart';

class PostContentProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return PostContent.fromJson(map);
      if (map is List)
        return map.map((item) => PostContent.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<PostContent?> getPostContent(int id) async {
    final response = await get('postcontent/$id');
    return response.body;
  }

  Future<Response<PostContent>> postPostContent(
          PostContent postcontent) async =>
      await post('postcontent', postcontent);
  Future<Response> deletePostContent(int id) async =>
      await delete('postcontent/$id');
}
