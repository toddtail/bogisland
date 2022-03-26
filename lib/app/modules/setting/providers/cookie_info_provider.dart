import 'package:bog_island/app/common/provider/bog_connect.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/cookie_info_model.dart';

class CookieInfoProvider extends BogConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      Logger().i(map);
      switch (map['code']) {
        case 6401:
          bogSnackBar('${map['code']}', '提交参数不完整');
          break;
        case 6402:
          bogSnackBar('${map['code']}', '饼干不存在');
          break;
      }
      if (map['code'] == 6001) {
        if (map is Map<String, dynamic>) return CookieInfo.fromJson(map);
        if (map is List) {
          return map.map((item) => CookieInfo.fromJson(item)).toList();
        }
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> postCookieInfo(String cookie, String code) async =>
      await post('userinfo', FormData({'cookie': cookie, 'code': code}));
}
