import 'package:get/get.dart';

import '../controllers/post_edit_controller.dart';

class PostEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostEditController>(
      () => PostEditController(),
    );
  }
}
