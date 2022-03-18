import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/global/widgets/forum_select_card.dart';
import 'package:get/get.dart';

class HomeBottomBarController extends GetxController {
  HomeBottomBarController();

  final iconSelectedState = [true, false, false, false, false].obs;
  final isOnForumSelect = false.obs;
  final forumController = Get.find<ForumController>();

  void onBarIconTap(int index) {
    // 点击动画逻辑
    if (index == 2) {
      iconSelectedState.value = [true, false, false, false, false];
      // isOnForumSelect.value = !isOnForumSelect.value;
      Get.bottomSheet(ForumSelectCard());
    } else if (index == 1 && iconSelectedState[0]) {
      forumController.refreshTopic();
    } else {
      iconSelectedState.value = [false, false, false, false, false];
      iconSelectedState[index - 1] = true;
      isOnForumSelect.value = false;
    }
  }

  void onTopicCellTaped() {
    isOnForumSelect.value = false;
  }
}
