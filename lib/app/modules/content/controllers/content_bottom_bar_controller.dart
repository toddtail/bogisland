import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:get/get.dart';

class ContentBottomBarController extends GetxController {
  ContentBottomBarController();

  final contentController = Get.find<ContentController>();

  void onBarIconTap(int index) {
    if(index == 2) {
      Get.toNamed('/post-edit',
            arguments: PostArgumentModel(
                isNewPost: false,
                topicId: contentController.topicId.value));
    }
    
  }


}
