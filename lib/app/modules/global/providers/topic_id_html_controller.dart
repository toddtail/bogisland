import 'package:bog_island/app/modules/global/models/thread_model.dart';
import 'package:bog_island/app/modules/global/providers/thread_provider.dart';
import 'package:get/get.dart';

class TopicIdHtmlController extends GetxController {
  TopicIdHtmlController();

  final threadProvider = Get.find<ThreadProvider>();
  final threadLoadedMap = {}.obs;

  String _loadingWords = '内容加载中...';
  String _failedWords = '加载失败';

  loadIdThread(String id) async {
    if (!threadLoadedMap.containsKey(id)) {
      threadLoadedMap[id] = 'loading';
      try {
        threadProvider.postThread(id).then((result) {
          if (result.body is Map) {
            threadLoadedMap.update(id, (value) => 'failed');
            threadLoadedMap.refresh();
          } else if (result.body is Thread) {
            print('thread');
            threadLoadedMap.update(
                id,
                (value) => [
                      result.body.info.cookie,
                      result.body.info.time,
                      result.body.info.content
                    ]);
          }
        });
      } catch (e) {
        threadLoadedMap[id] = 'failed';
      }
    }
  }
}
