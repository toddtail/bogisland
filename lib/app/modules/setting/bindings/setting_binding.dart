import 'package:bog_island/app/modules/setting/providers/cookie_add_provider.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_del_provider.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_get_provider.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';
import '../providers/cookie_info_provider.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
    Get.lazyPut<CookieAddProvider>(
      () => CookieAddProvider(),
    );
    Get.lazyPut<CookieGetProvider>(
      () => CookieGetProvider(),
    );
    Get.lazyPut<CookieDelProvider>(
      () => CookieDelProvider(),
    );
    Get.lazyPut<CookieInfoProvider>(
      () => CookieInfoProvider(),
    );
  }
}
