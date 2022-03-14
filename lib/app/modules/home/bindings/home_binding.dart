import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/forum/providers/forum_provider.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
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
  }
}
