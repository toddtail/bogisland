import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:bog_island/app/modules/forum/models/forum_model.dart' as fm;
import 'package:get/get.dart';

class ContentController extends GetxController {
  //TODO: Implement ContentController

  final threadsProvider = Get.find<ThreadsProvider>();
  final contentList = [].obs;
  final originalInfo = fm.Info().obs;
  int _currentLoadedPage = 0;
  final topicId = 0.obs;
  final topicIndexInForum = 0.obs;
  final isOnLoad = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('ContentController init');
    // loadContent();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print('ContentController onClose');
  }

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
