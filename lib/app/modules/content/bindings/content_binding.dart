import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:get/get.dart';

import '../controllers/content_controller.dart';

class ContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentController>(
      () => ContentController(),
    );
    Get.lazyPut<ThreadsProvider>(
      () => ThreadsProvider(),
    );
  }
}
