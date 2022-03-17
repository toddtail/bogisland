import 'package:get/get.dart';

class MarkController extends GetxController {
  //TODO: Implement MarkController

  final count = 0.obs;
  @override
  void onInit() {
    print('MarkController oninit');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
