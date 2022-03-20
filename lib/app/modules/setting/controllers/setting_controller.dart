import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/setting/models/cookie_add_model.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingController extends GetxController {
  final storage = GetStorage();
  final cookieAddProvider = Get.find<CookieAddProvider>();
  final cookieList = [].obs;

  @override
  void onInit() {
    print('SettingController oninit');
    readStorageCookies();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void writeStorageCookies() {
    storage.write('cookie', cookieList.value);
  }

  void readStorageCookies() {
    if (storage.hasData('cookie')) {
      print(storage.read('cookie').runtimeType);
      List tempList = storage.read('cookie');
      cookieList.value = List.generate(
          tempList.length, (index) => Info.fromJson(tempList[index]));
    }
  }

  addCookie(String cookieAdd) async {
    String master;
    if (cookieList.isNotEmpty) {
      master = cookieList[0].cookie!;
    } else {
      master = '0';
    }
    dynamic result = await cookieAddProvider.postCookieAdd(master, cookieAdd);
    if (result.body.info is List<Info>) {
      cookieList.value = result.body.info;
      writeStorageCookies();
      return true;
    } else {
      return false;
    }
  }

  void importCookie() {
    String input = '';
    Get.dialog(
      AlertDialog(
        title: const Text('导入饼干'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('导入已有的主饼干，请勿导入影武者'),
            TextField(
              minLines: 1,
              maxLines: 3,
              style: TextStyle(fontSize: 16.sp),
              decoration: const InputDecoration(isDense: true),
              onChanged: (text) {
                input = text;
              },
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('取消').textColor(colorNeutral400)),
          TextButton(
              onPressed: () async {
                print(input);
                bool result = await addCookie(input);
                if (result) {
                  Get.back();
                }
              },
              child: const Text('导入'))
        ],
      ),
    );
  }

  void removeMasterCookie() {
    Get.dialog(AlertDialog(
      title: const Text('删除主饼干?'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('取消').textColor(colorSky300)),
        TextButton(
            onPressed: () {
              cookieList.value = [];
              storage.remove('cookie');
              Get.back();
            },
            child: const Text('删除').textColor(colorRed300))
      ],
    ));
  }
}
