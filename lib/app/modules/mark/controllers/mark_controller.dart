import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class MarkController extends GetxController {
  final storage = GetStorage();

  final markTopicList = [].obs;

  final isMarkListEmpty = true.obs;

  final _tMarkKey = 'mark';

  @override
  void onInit() {
    Logger().i('MarkController oninit');
    super.onInit();
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
    } else {
      isMarkListEmpty.value = true;
      markTopicList.value = storage.read(_tMarkKey);
    }
  }

  void jumpToContent(int index) {
    Get.toNamed("/content",
        arguments: ContentArgumentModel(
            topicId: markTopicList[index].id, topicIndexInForum: index));
  }

  void addTopicToMark(TopicInfo info) {

  }

  void removeTopicFromMark(int index) {

  }
}
