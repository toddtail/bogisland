import 'package:bog_island/app/common/function/topic_to_threads_transfer.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:bog_island/app/modules/forum/providers/forum_provider.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// 板块包含内容
class ForumController extends GetxController {
  final forumProvider = Get.find<ForumProvider>();
  final forumListController = Get.find<ForumListController>();
  final forumTopicList = [].obs;
  final selectedForumId = 0.obs;
  int _currentLoadedPage = 0;
  bool _loadLock = false;

  @override
  void onInit() async {
    super.onInit();
    Logger().i('ForumController init');
    await forumListController.getForumList();
    loadTopic();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Logger().i('ForumController onClose');
  }

  void loadTopic() async {
    if (!_loadLock) {
      _currentLoadedPage = _currentLoadedPage + 1;
      _loadLock = true;
      try {
        await forumProvider
            .postForum(selectedForumId.value, _currentLoadedPage)
            .then((value) {
          if (value.body is Map) {
            // TODO error display
          } else if (value.body is TopicsInForum) {
            TopicsInForum result = value.body;
            forumTopicList.addAll(result.info!);
          }
        });
        _loadLock = false;
      } catch (e) {
        rethrow;
      }
    }
  }

  void reloadTopic(int id) {
    forumTopicList.value = [];
    _currentLoadedPage = 0;
    selectedForumId.value = id;
    loadTopic();
  }

  void refreshTopic() {
    forumTopicList.value = [];
    _currentLoadedPage = 0;
    loadTopic();
  }

  void jumpToContent(int index) {
    Get.toNamed("/content", arguments: ContentArgumentModel(
       topicData: forumTopicList[index], heroType: 'forum'));
  }
}
