import 'package:bog_island/app/modules/forum/models/forum_model.dart';
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
    await forumProvider.getForum(0, 1).then((value) {
      if(value.body is Map) {
        // TODO error display
      } else if(value.body is Forum) {
        Forum result = value.body;
        print(result.info!.length);
      }
    });
  }

  void test() {
    print('test');
  }
}
