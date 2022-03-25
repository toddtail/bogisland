import 'package:bog_island/app/common/provider/bog_post_connect.dart';
import 'package:get/get.dart';

import '../models/post_content_model.dart';

class PostContentProvider extends BogPostConnect {
  @override
  void onInit() {
    super.onInit();

    httpClient.defaultDecoder = (map) {
      print(map);
      switch (map['code']) {
        case 4:
          bogSnackBar('${map['code']}', '该饼干的发布功能被暂时禁用');
          break;
        case 1000:
          bogSnackBar('${map['code']}', '该饼干的发布功能被暂时禁用');
          break;
        case 1001:
          bogSnackBar('${map['code']}', '没有饼干，但是饼干领取开放中');
          break;
        case 1002:
          bogSnackBar('${map['code']}', '不存在');
          break;
        case 1003:
          bogSnackBar('${map['code']}', '既没有图片也没有内容，无法发布');
          break;
        case 1004:
          bogSnackBar('${map['code']}', '选择的影武者不存在');
          break;
        case 1005:
          bogSnackBar('${map['code']}', '图片数量超过上限');
          break;
        case 1006:
          bogSnackBar('${map['code']}', '发送图片的参数错误');
          break;
        case 1008:
          bogSnackBar('${map['code']}', '无法发布内容，因为包含图片');
          break;
        case 1100:
          bogSnackBar('${map['code']}', '没有选择版块');
          break;
        case 1101:
          bogSnackBar('${map['code']}', '回复的目标不存在或已锁定');
          break;
        case 1102:
          bogSnackBar('${map['code']}', '近期发布过相同内容');
          break;
        case 1201:
          bogSnackBar('${map['code']}', '一个未知的错误，请尝试重新提交');
          break;
        case 9900:
          bogSnackBar('${map['code']}', '该主题仅发布者可回复');
          break;
        case 9901:
          bogSnackBar('${map['code']}', '该板块需要特殊代码才能发布');
          break;
      }
      if (map['code'] == 1) {
        if (map is Map<String, dynamic>) return PostContent.fromJson(map);
        if (map is List)
          return map.map((item) => PostContent.fromJson(item)).toList();
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> postContent(
          String cookie, Map<String, dynamic> data) async =>
      await post('post', FormData(data), headers: {'Cookie': cookie});
}
