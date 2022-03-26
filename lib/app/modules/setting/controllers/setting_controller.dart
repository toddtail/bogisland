import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/setting/models/cookie_add_model.dart';
import 'package:bog_island/app/modules/setting/models/cookie_del_model.dart';
import 'package:bog_island/app/modules/setting/models/cookie_get_model.dart';
import 'package:bog_island/app/modules/setting/models/cookie_info_model.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_add_provider.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_del_provider.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_get_provider.dart';
import 'package:bog_island/app/modules/setting/providers/cookie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingController extends GetxController {
  // cookie cookie_master cookie_selected_index
  final storage = GetStorage();
  final cookieAddProvider = Get.find<CookieAddProvider>();
  final cookieInfoProvider = Get.find<CookieInfoProvider>();
  final cookieDelProvider = Get.find<CookieDelProvider>();
  final cookieGetProvider = Get.find<CookieGetProvider>();

  final cookieList = <CookieAddInfo>[].obs;

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

  // 为0时不更新主cookie
  void writeStorageCookies(String cookieMaster) {
    storage.write(
        'cookie',
        List.generate(
            cookieList.length, (index) => cookieList[index].toJson()));
    if (cookieMaster != '0') {
      storage.write('cookie_master', cookieMaster);
    }
  }

  void readStorageCookies() {
    if (storage.hasData('cookie')) {
      // print(storage.read('cookie').runtimeType);
      List tempList = storage.read('cookie');
      cookieList.value = List.generate(
          tempList.length, (index) => CookieAddInfo.fromJson(tempList[index]));
    }
    updateCookieList();
  }

  addCookie(String cookieAdd) async {
    String master;
    if (cookieList.isNotEmpty) {
      // master = cookieList[0].cookie!;
      master = storage.read('cookie_master');
    } else {
      master = '0';
    }
    dynamic result = await cookieAddProvider.postCookieAdd(master, cookieAdd);
    if (result.body is CookieAdd) {
      cookieList.value = result.body.info;
      if (master == '0') {
        master = cookieAdd;
        setCookieSelectedForPost(0);
      }
      writeStorageCookies(master);
      return true;
    } else {
      return false;
    }
  }

  // TODO move ui to widgets
  void importCookie() {
    String input = '';
    Get.dialog(
      AlertDialog(
        title: const Text('导入饼干'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('导入过往已生成的饼干。\n\n应用会保存主饼干完整代码至本地，但不会保存影武者完整代码。'),
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
      title: const Text('移除主饼干?'),
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
              storage.remove('cookie_master');
              storage.remove('cookie_selected_index');
              Get.back();
            },
            child: const Text('删除').textColor(colorRed300))
      ],
    ));
  }

  void removeShadowCookie(String del) {
    Get.dialog(AlertDialog(
      title: const Text('删除影武者饼干?'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('取消').textColor(colorSky300)),
        TextButton(
            onPressed: () {
              String cookieMaster = storage.read('cookie_master');
              String cookie = cookieMaster.split('#')[0];
              String code = cookieMaster.split('#')[1];
              cookieDelProvider.postCookieDel(cookie, code, del).then((value) {
                if (value.body is CookieDel) {
                  updateCookieList();
                  // TODO 加判断
                  setCookieSelectedForPost(0);
                  Get.back();
                }
              });
            },
            child: const Text('删除').textColor(colorRed300))
      ],
    ));
  }

  //更新 Cookie 影武者
  void updateCookieList() {
    if (storage.hasData('cookie_master')) {
      String cookieMaster = storage.read('cookie_master');
      String cookie = cookieMaster.split('#')[0];
      String code = cookieMaster.split('#')[1];
      cookieInfoProvider.postCookieInfo(cookie, code).then((value) {
        if (value.body is CookieInfo) {
          cookieList.value = value.body.info.list;
        }
        writeStorageCookies('0');
      });
    }
  }

  void getNewCookie() {
    String newCookie = '';
    cookieGetProvider.getCookieGet().then((value) {
      if (value.body is CookieGet) {
        newCookie = value.body.info;
        Get.dialog(AlertDialog(
          title: const SelectableText('获取新饼干成功'),
          content: Text(newCookie),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('返回')),
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: newCookie));
                  Get.back();
                },
                child: const Text('复制到剪贴板'))
          ],
        ));
      }
    });
  }

  void setCookieSelectedForPost(int index) {
    storage.write('cookie_selected_index', index);
  }
}
