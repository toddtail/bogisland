import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/cookie_del_model.dart';

class CookieDelProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      Logger().i(map);
      switch (map['code']) {
        case 3001:
          bogSnackBar('${map['code']}', '提交参数不完整');
          break;
        case 3005:
          bogSnackBar('${map['code']}', '主饼干无法删除');
          break;
        case 3006:
          bogSnackBar('${map['code']}', '不是自己的饼干无法执行');
          break;
        case 3103:
          bogSnackBar('${map['code']}', '主饼干是无效的，无法执行影武者操作');
          break;
        case 3105:
          bogSnackBar('${map['code']}', '没有要执行的饼干');
          break;
      }
      if (map['code'] == 3007) {
        if (map is Map<String, dynamic>) return CookieDel.fromJson(map);
        if (map is List)
          return map.map((item) => CookieDel.fromJson(item)).toList();
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> postCookieDel(
          String cookie, String code, String del) async =>
      await post(
          'cookiedel', FormData({'cookie': cookie, 'code': code, 'del': del}));
}
