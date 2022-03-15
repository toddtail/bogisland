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
  int _id = 0;
  bool _onLoad = false;

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
  void onClose() {}

  // void openNewContent(fm.Info originalInfo) async {
  //   originalInfo = originalInfo;
  //   _id = originalInfo.id!;
  //   _currentLoadedPage = 0;
  //   loadContent();
  // }

  void openNewContent(int id) async {
    _id = id;
    _currentLoadedPage = 0;
    loadContent();
  }

  void loadContent() async {
    if (!_onLoad) {
      _currentLoadedPage = _currentLoadedPage + 1;
      Response result;
      _onLoad = true;
      try {
        result = await threadsProvider.postThreads(_id, _currentLoadedPage);
      }catch(e) {
        rethrow;
      }
      _onLoad = false;
      if (result.body is Map) {
        //TODO error display
      } else if (result.body is Threads) {
        contentList.addAll(result.body.info!.reply!);
      }
    }
  }
}
