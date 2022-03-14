import 'dart:ffi';

import 'package:bog_island/app/modules/global/models/forum_list_model.dart';
import 'package:bog_island/app/modules/global/providers/forum_list_provider.dart';
import 'package:get/get.dart';

class ForumListController extends GetxController {
  ForumListController();

  final fullForumList = [].obs;
  final liteForumMap = {}.obs;

  final forumListProvider = Get.find<ForumListProvider>();

  @override
  void onInit() async {
    super.onInit();
    // getForumList();
    print('ForumListController init');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getForumList() async {
    await forumListProvider.getForumList().then((value) {
      fullForumList.value = value!.info!;
      for (Info info in fullForumList) {
        liteForumMap.addAll({info.id: '${info.name}'});
      }
    });
    return true;
  }
}
