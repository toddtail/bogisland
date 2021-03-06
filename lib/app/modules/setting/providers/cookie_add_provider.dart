import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/cookie_add_model.dart';

class CookieAddProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      Logger().i(map);
      switch (map['code']) {
        case 3001:
        bogSnackBar('${map['code']}', '饼干无效，系统中没有记录这块饼干');
          break;
        case 3002:
        bogSnackBar('${map['code']}', '饼干已被删除');
          break;
        case 3101:
        bogSnackBar('${map['code']}', '已经是影武者的饼干，无法再次导入');
          break;
        case 3103:
        bogSnackBar('${map['code']}', '主饼干无效的，无法执行影武者操作');
          break;
        case 3106:
        bogSnackBar('${map['code']}', '影武者已达上限，无法继续导入');
          break;
      }
      if (map['code'] == 3104) {
        if (map is Map<String, dynamic>) return CookieAdd.fromJson(map);
        if (map is List)
          return map.map((item) => CookieAdd.fromJson(item)).toList();
      } else {
        return map as Map;
      }
    };
  }

  Future<Response<dynamic>> postCookieAdd(
      String master, String cookieAdd) async {
    FormData data = FormData({'master': master, 'cookieadd': cookieAdd});
    return await post('cookieAdd', data);
  }
}
