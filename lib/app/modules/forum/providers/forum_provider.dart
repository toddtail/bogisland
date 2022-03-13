import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:get/get.dart';

import '../models/forum_model.dart';

class ForumProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      print(map);
      if (map['type'] == 'error') {
        // print(map['info']);
        return map as Map;
      }
      if (map is Map<String, dynamic>) return Forum.fromJson(map);
      if (map is List) return map.map((item) => Forum.fromJson(item)).toList();
    };
  }

  Future<Response<dynamic>> postForum(int id, int page) async {
    Map<String, dynamic> body = {'id': id, 'page': page};
    return await post('forum', body);
  }
}
