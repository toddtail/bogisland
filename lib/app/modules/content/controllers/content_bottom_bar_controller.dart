import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/mark/controllers/mark_controller.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class ContentBottomBarController extends GetxController {
  // use contentController get topic id and index in forum
  final contentController = Get.find<ContentController>();
  // use markController operate mark
  final markController = Get.find<MarkController>();

  final isTopicMarked = false.obs;

  final storage = GetStorage();

  @override
  void onInit() {
    Logger().i('ContentBottomBarController oninit');
    checkMarkState();
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
        markController.addTopicToMark(contentController.originalTopicInfo);
      }
      checkMarkState();
    }
    if (index == 2) {
      if (storage.hasData('cookie')) {
        Get.toNamed('/post-edit',
            arguments: PostArgumentModel(
                isNewPost: false, topicId: contentController.topicId.value));
      } else {
        showWarnSnackBar('请先导入饼干', '没有饼干无法发帖');
      }
    }
  }

  void checkMarkState() {
    isTopicMarked.value =
        markController.isTopicInMark(contentController.topicId.value);
  }
}
