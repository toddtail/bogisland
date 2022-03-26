import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BogConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://bog.ac/api/';
  }

  void bogSnackBar(String code, String content) {
    Get.snackbar(code, content,
        duration: const Duration(seconds: 2), backgroundColor: colorAmber200);
  }
}
