import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:get/get.dart';

void showWarnSnackBar(String title, String message) {
  Get.snackbar(title, message, duration: const Duration(seconds: 2),
              backgroundColor: colorRed200);
}
