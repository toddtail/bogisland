import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:get/get.dart';

import '../models/topics_in_forum_model.dart';

class ForumProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      if (map['type'] == 'error') {
        return map as Map;
      }
      if (map is Map<String, dynamic>) return TopicsInForum.fromJson(map);
      if (map is List) return map.map((item) => TopicsInForum.fromJson(item)).toList();
    };
  }

  Future<Response<dynamic>> getForum(int id, int page) async {
    String body = '/$id/$page';
    return await get('forum$body');
  }

  Future<Response<dynamic>> postForum(int id, int page) async {
    FormData data = FormData({'id': id, 'page': page});
    return await post('forum', data);
  }
}
