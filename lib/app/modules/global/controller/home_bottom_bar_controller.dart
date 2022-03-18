import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/global/widgets/forum_select_card.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeBottomBarController extends GetxController {
  HomeBottomBarController();

  late PageController pageController;
  final iconSelectedState = [true, false, false, false, false].obs;
  final isOnForumSelect = false.obs;
  final forumController = Get.find<ForumController>();
  final List _jumpList = [0, 0, 1, 0, 2];
  final List _pageChangedList = [0,2,4];

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
