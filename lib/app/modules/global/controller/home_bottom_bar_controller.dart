import 'package:get/get.dart';

class HomeBottomBarController extends GetxController {
  HomeBottomBarController();

  final iconSelectedState = [true, false, false, false, false].obs;

  void onBarIconTap(int index) {
    // 点击动画逻辑
    if (index != 2) {
      iconSelectedState.value = [false, false, false, false, false];
      iconSelectedState[index - 1] = true;
    } else {
      iconSelectedState.value = [true, false, false, false, false];
    }

    print(index);
  }
}
