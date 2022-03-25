import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';

class BogPostConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://bog.ac/post/';
  }

  void bogSnackBar(String code, String content) {
    try {
      Get.snackbar(code, content,
          duration: const Duration(seconds: 2), backgroundColor: colorAmber200);
    } catch (e) {
      return;
    }
  }
}
