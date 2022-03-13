import 'package:bog_island/app/modules/forum/providers/forum_provider.dart';
import 'package:get/get.dart';

import '../controllers/forum_controller.dart';

class ForumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForumController>(
      () => ForumController(),
    );
    Get.lazyPut<ForumProvider>(
      () => ForumProvider(),
    );
  }
}
