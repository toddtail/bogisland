import 'package:bog_island/app/modules/post_edit/controllers/post_bottom_bar_controller.dart';
import 'package:get/get.dart';

import '../controllers/post_edit_controller.dart';

class PostEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostEditController>(
      () => PostEditController(),
    );
    Get.lazyPut<PostBottomBarController>(
      () => PostBottomBarController(),
    );
  }
}
