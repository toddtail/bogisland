import 'package:bog_island/app/modules/content/controllers/content_bottom_bar_controller.dart';
import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:bog_island/app/modules/global/providers/thread_provider.dart';
import 'package:bog_island/app/modules/global/providers/topic_id_html_controller.dart';
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
    Get.lazyPut<ContentBottomBarController>(
      () => ContentBottomBarController(),
    );
    Get.lazyPut<TopicIdHtmlController>(
      () => TopicIdHtmlController(),
    );
    Get.lazyPut<ThreadProvider>(() => ThreadProvider());
  }
}
