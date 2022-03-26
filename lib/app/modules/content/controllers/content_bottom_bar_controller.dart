import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/mark/controllers/mark_controller.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ContentBottomBarController extends GetxController {
  // use contentController get topic id and index in forum
  final contentController = Get.find<ContentController>();
  // use markController operate mark
  final markController = Get.find<MarkController>();
  // use forumController get original topic info data
  final forumController = Get.find<ForumController>();

  final isTopicMarked = false.obs;

  @override
  void onInit() {
    Logger().i('ContentBottomBarController oninit');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onBarIconTap(int index) {
    if (index == 1) {
      if (isTopicMarked.value) {
        markController.removeTopicFromMark(contentController.topicId.value);
      } else {
        markController.addTopicToMark(forumController
            .forumTopicList[contentController.topicIndexInForum.value]);
      }
      checkMarkState();
    }
    if (index == 2) {
      Get.toNamed('/post-edit',
          arguments: PostArgumentModel(
              isNewPost: false, topicId: contentController.topicId.value));
    }
  }

  void checkMarkState() {
    isTopicMarked.value =
        markController.isTopicInMark(contentController.topicId.value);
  }
}
