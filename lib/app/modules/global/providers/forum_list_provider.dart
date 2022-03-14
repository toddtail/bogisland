import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:get/get.dart';

import '../models/forum_list_model.dart';

class ForumListProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ForumList.fromJson(map);
      if (map is List)
        return map.map((item) => ForumList.fromJson(item)).toList();
    };
  }

  Future<ForumList?> getForumList() async {
    final response = await get('forumlist');
    return response.body;
  }
}
