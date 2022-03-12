import 'package:get/get.dart';

import '../controllers/content_controller.dart';

class ContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentController>(
      () => ContentController(),
    );
  }
}
