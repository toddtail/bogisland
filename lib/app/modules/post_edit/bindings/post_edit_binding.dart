import 'package:bog_island/app/modules/post_edit/providers/image_upload_provider.dart';
import 'package:bog_island/app/modules/post_edit/providers/post_content_provider.dart';
import 'package:get/get.dart';

import '../controllers/post_edit_controller.dart';

class PostEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostEditController>(
      () => PostEditController(),
    );
    Get.lazyPut<ImageUploadProvider>(
      () => ImageUploadProvider(),
    );
    Get.lazyPut<PostContentProvider>(
      () => PostContentProvider(),
    );
  }
}
