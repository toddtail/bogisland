import 'package:get/get.dart';

import '../cookie_add_model.dart';

class CookieAddProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return CookieAdd.fromJson(map);
      if (map is List)
        return map.map((item) => CookieAdd.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<CookieAdd?> getCookieAdd(int id) async {
    final response = await get('cookieadd/$id');
    return response.body;
  }

  Future<Response<CookieAdd>> postCookieAdd(CookieAdd cookieadd) async =>
      await post('cookieadd', cookieadd);
  Future<Response> deleteCookieAdd(int id) async =>
      await delete('cookieadd/$id');
}
