import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/common/function/topic_to_threads_transfer.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class MarkController extends GetxController {
  final storage = GetStorage();

  final markTopicList = <TopicInfo>[].obs;

  final isMarkListEmpty = true.obs;

  final _tMarkKey = 'mark';

  @override
  void onInit() {
    Logger().i('MarkController oninit');
    super.onInit();
    readMarkList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void initMarkList() {
    readMarkList();
  }

  void readMarkList() {
    if (storage.hasData(_tMarkKey)) {
      isMarkListEmpty.value = false;
      final List tempList = storage.read(_tMarkKey);
      markTopicList.value = List.generate(
          tempList.length, (index) => TopicInfo.fromJson(tempList[index]));
    } else {
      isMarkListEmpty.value = true;
    }
  }

  void jumpToContent(int index) {
    Get.toNamed("/content",
        arguments: ContentArgumentModel(topicData: markTopicList[index]));
  }

  void addTopicToMark(TopicInfo info) {
    int? index;
    for (int i = 0; i < markTopicList.length; i++) {
      if (markTopicList[i].id == info.id) {
        index = i;
        continue;
      }
    }
    if (index == null) {
      showNormalSnackBar('收藏成功', '已添加至本地收藏列表');
      markTopicList.insert(0, info);
      writeToLocalStorage();
    } else {
      showWarnSnackBar('收藏错误', '已收藏此帖子');
    }
    readMarkList();
  }

  void removeTopicFromMark(int topicId) {
    int? index;
    for (int i = 0; i < markTopicList.length; i++) {
      if (markTopicList[i].id == topicId) {
        index = i;
        continue;
      }
    }
    if (index != null) {
      showNormalSnackBar('取消收藏成功', '已从本地收藏列表移出');
      markTopicList.removeAt(index);
      writeToLocalStorage();
    } else {
      showWarnSnackBar('取消收藏错误', '并未收藏此帖子');
    }
    readMarkList();
  }

  void writeToLocalStorage() {
    if (markTopicList.isEmpty) {
      storage.remove(_tMarkKey);
    } else {
      final tempList = List.generate(
          markTopicList.length, (index) => markTopicList[index].toJson());
      storage.write(_tMarkKey, tempList);
    }
  }

  bool isTopicInMark(int topicId) {
    Logger().i(topicId);
    for (TopicInfo info in markTopicList) {
      
      Logger().i(info.id);
      if (info.id == topicId) {
        return true;
      }
    }
    return false;
  }
}
