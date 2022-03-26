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
      final List tempList = storage.read(_tMarkKey);
      markTopicList.value = List.generate(
          tempList.length, (index) => TopicInfo.fromJson(tempList[index]));
    }
  }

  void jumpToContent(int index) {
    Get.toNamed("/content",
        arguments: ContentArgumentModel(
            topicId: markTopicList[index].id, topicIndexInForum: index));
  }

  void addTopicToMark(TopicInfo info) {
    markTopicList.insert(0, info);
    writeToLocalStorage();
  }

  void removeTopicFromMark(int index) {
    markTopicList.removeAt(index);
    writeToLocalStorage();
  }

  void writeToLocalStorage() {
    final tempList = List.generate(
        markTopicList.length, (index) => markTopicList[index].toJson());
    storage.write(_tMarkKey, tempList);
  }

  
}
