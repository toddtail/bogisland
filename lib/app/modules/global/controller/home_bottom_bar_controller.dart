import 'package:get/get.dart';

class HomeBottomBarController extends GetxController {
  HomeBottomBarController();

  final iconSelectedState = [true, false, false, false].obs;

  void onBarIconTap(int index) {
    if (index != 2) {
      iconSelectedState.value = [false, false, false, false];
      iconSelectedState[index - 1] = true;
    } else {
      iconSelectedState.value = [true, false, false, false];
    }

    print(index);
  }
}
