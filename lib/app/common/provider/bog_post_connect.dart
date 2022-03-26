import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BogPostConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://bog.ac/post/';
    httpClient.timeout = const Duration(seconds: 50);
  }

  void bogSnackBar(String code, String content) {
    Get.snackbar(code, content,
        duration: const Duration(seconds: 2), backgroundColor: colorAmber200);
  }
}
