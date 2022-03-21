import 'package:bog_island/app/common/provider/bog_post_connect.dart';
import 'package:get/get.dart';

import '../models/cookie_get_model.dart';

class CookieGetProvider extends BogPostConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) {
      print(map);
      switch (map['code']) {
        case 2001:
          bogSnackBar('${map['code']}', '饼干领取限制，一定时间后才能领取');
          break;
        case 2002:
          bogSnackBar('${map['code']}', '当前关闭了饼干领取');
          break;
        case 2003:
          bogSnackBar('${map['code']}', 'IP地址不合理，有可能是伪造的IP地址');
          break;
        case 2004:
          bogSnackBar('${map['code']}', '饼干领取系统调用限制');
          break;
        case 2005:
          bogSnackBar('${map['code']}', 'IP地址不在系统允许的范围内');
          break;
      }
      if (map['code'] == 2) {
        if (map is Map<String, dynamic>) return CookieGet.fromJson(map);
        if (map is List)
          return map.map((item) => CookieGet.fromJson(item)).toList();
      } else {
        return map;
      }
    };
  }

  Future<Response<dynamic>> getCookieGet() async {
    return await get('cookieget');
  }
}
