import 'package:bog_island/app/data/version.dart';
import 'package:bog_island/app/modules/home/providers/version_check_provider.dart';
import 'package:bog_island/app/modules/home/widgets/update_dialog.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
  final versionCheckProvider = Get.find<VersionCheckProvider>();

  @override
  void onInit() {
    Logger().i('HomeController init');
    super.onInit();
    
  }

  @override
  void onReady() {
    super.onReady();
    Logger().i('HomeController onReady');
    checkVersionUpdate();
  }

  @override
  void onClose() {}

  void checkVersionUpdate() {
    try {
      versionCheckProvider.getVersionInfo().then((value) {
        if (value!.versionCode! > appVersionCode) {
          Get.dialog(updateDialog(
              value.versionName!, value.versionContent!, value.versionUrl!));
        }
      });
    } catch (e) {
      return;
    }
  }

  void activeController() {
    Logger().i('Active HomeController');
  }
}
