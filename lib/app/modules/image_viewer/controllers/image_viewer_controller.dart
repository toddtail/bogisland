import 'package:bog_island/app/common/function/notify.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageViewerController extends GetxController {
  //TODO: Implement ImageViewerController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<Map> saveImageToLocal(String url) async {
    if (await Permission.storage.request().isGranted) {
      var data = await getNetworkImageData(url, useCache: true);
      //TODO save path change
      final result = await ImageGallerySaver.saveImage(
        data!,
        quality: 100,
      );
      if(result['isSuccess']) {
        showNormalSnackBar('保存图片成功', result['filePath']);
      }
    }
    return {'isSuccess': false};
  }
}
