import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/forum/providers/forum_provider.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
import 'package:bog_island/app/modules/global/providers/forum_list_provider.dart';
import 'package:bog_island/app/modules/mark/controllers/mark_controller.dart';
import 'package:bog_island/app/modules/setting/controllers/setting_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HomeBottomBarController>(
      () => HomeBottomBarController(),
    );

    Get.lazyPut<ForumController>(
      () => ForumController(),
    );
    Get.lazyPut<ForumProvider>(
      () => ForumProvider(),
    );

    Get.lazyPut<ForumListController>(
      () => ForumListController(),
    );
    Get.lazyPut<ForumListProvider>(
      () => ForumListProvider(),
    );

    Get.lazyPut<MarkController>(
      () => MarkController(),
    );

    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
