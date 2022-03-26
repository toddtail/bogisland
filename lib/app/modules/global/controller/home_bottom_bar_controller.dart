import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/global/widgets/forum_select_card.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeBottomBarController extends GetxController {
  HomeBottomBarController();

  late PageController pageController;
  final iconSelectedState = [true, false, false, false, false].obs;
  final isOnForumSelect = false.obs;
  final forumController = Get.find<ForumController>();
  final List _jumpList = [0, 0, 1, 0, 2];
  final List _pageChangedList = [0, 2, 4];
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onBarIconTap(int index) {
    // 点击动画逻辑
    if (index == 2) {
      iconSelectedState.value = [true, false, false, false, false];
      Get.bottomSheet(ForumSelectCard());
    } else if (index == 1 && iconSelectedState[0]) {
      forumController.refreshTopic();
    } else if (index == 4) {
      // Logger().i(storage.hasData('cookie'));
      if (storage.hasData('cookie')) {
        Get.toNamed('/post-edit',
            arguments: PostArgumentModel(
                isNewPost: true,
                forumId: forumController.selectedForumId.value));
      } else {
        showWarnSnackBar('请先导入饼干', '没有饼干无法发帖');
      }
    } else {
      iconSelectedState.value = [false, false, false, false, false];
      iconSelectedState[index - 1] = true;
      isOnForumSelect.value = false;
    }
    if (index != 4) {
      pageController.animateToPage(_jumpList[index - 1],
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  void onPageChanged(int index) {
    iconSelectedState.value = [false, false, false, false, false];
    iconSelectedState[_pageChangedList[index]] = true;
  }

  void onTopicCellTaped() {
    isOnForumSelect.value = false;
  }
}
