import 'package:bog_island/app/modules/forum/providers/forum_provider.dart';
import 'package:get/get.dart';

class ForumController extends GetxController {
  final forumProvider = Get.find<ForumProvider>();
  final forumTopicList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    print('ForumController init');
    _readTopic();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void _readTopic() async {
    dynamic forumTopicListResult = forumProvider.postForum(0, 1);
    print(forumTopicListResult);
  }

  void test() {
    print('test');
  }
}
