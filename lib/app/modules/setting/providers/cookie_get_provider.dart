import 'package:get/get.dart';

import '../models/cookie_get_model.dart';

class CookieGetProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return CookieGet.fromJson(map);
      if (map is List)
        return map.map((item) => CookieGet.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<CookieGet?> getCookieGet(int id) async {
    final response = await get('cookieget/$id');
    return response.body;
  }

  Future<Response<CookieGet>> postCookieGet(CookieGet cookieget) async =>
      await post('cookieget', cookieget);
  Future<Response> deleteCookieGet(int id) async =>
      await delete('cookieget/$id');
}
