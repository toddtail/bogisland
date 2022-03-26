import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart' ;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ContentController extends GetxController {
  //TODO: Implement ContentController

  final threadsProvider = Get.find<ThreadsProvider>();
  final contentList = [].obs;
  final originalInfo = TopicInfo().obs;
  int _currentLoadedPage = 0;
  final topicId = 0.obs;
  final topicIndexInForum = 0.obs;
  final isOnLoad = false.obs;

  @override
  void onInit() {
    super.onInit();
    Logger().i('ContentController init');
    // loadContent();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Logger().i('ContentController onClose');
  }

  // arguments passed in view 
  // use this function to init paramaters
  void openNewContent(ContentArgumentModel model) async {
    topicId.value = model.topicId!;
    topicIndexInForum.value = model.topicIndexInForum!;
    _currentLoadedPage = 0;
    loadContent();
  }

  void loadContent() async {
    // TODO page load lock
    if (!isOnLoad.value) {
      _currentLoadedPage = _currentLoadedPage + 1;
      Response result;
      isOnLoad.value = true;
      try {
        result = await threadsProvider.postThreads(
            topicId.value, _currentLoadedPage);
      } catch (e) {
        rethrow;
      }
      if (result.body is Map) {
        //TODO error display
      } else if (result.body is Threads) {
        contentList.addAll(result.body.info!.reply!);
      }
      isOnLoad.value = false;
    }
  }

  void refreshContent() {
    _currentLoadedPage = 0;
    contentList.value = [];
    loadContent();
  }
}
