import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  //TODO: Implement ContentController

  final threadsProvider = Get.find<ThreadsProvider>();
  final contentList = [].obs;


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

  void loadContent(int id) async{
    dynamic result = threadsProvider.postThreads();
    print(result);
  }

}
