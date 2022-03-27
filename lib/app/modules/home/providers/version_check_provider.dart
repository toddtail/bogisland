import 'package:get/get.dart';

import '../models/version_check_model.dart';

class VersionCheckProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return VersionCheck.fromJson(map);
      if (map is List)
        return map.map((item) => VersionCheck.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://toddtail.com/api/bog/android/';
  }

  Future<VersionCheck?> getVersionInfo() async {
    final response = await get('version.json');
    return response.body;
  }

}
