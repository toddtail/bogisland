import 'package:get/get.dart';

import '../controllers/mark_controller.dart';

class MarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarkController>(
      () => MarkController(),
    );
  }
}
