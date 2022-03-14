import 'package:bog_island/app/modules/forum/models/forum_model.dart';
import 'package:bog_island/app/modules/forum/providers/forum_provider.dart';
import 'package:get/get.dart';

class ForumController extends GetxController {
  final forumProvider = Get.find<ForumProvider>();
  final forumTopicList = [].obs;
  int _currentLoadedPage = 0;

  @override
  void onInit() async {
    super.onInit();
    print('ForumController init');
    loadTopic();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void loadTopic() async {
    _currentLoadedPage = _currentLoadedPage + 1;
    await forumProvider.getForum(0, _currentLoadedPage).then((value) {
      if(value.body is Map) {
        // TODO error display
      } else if(value.body is Forum) {
        Forum result = value.body;
        forumTopicList.addAll(result.info!);
      }
    });
  }
}
