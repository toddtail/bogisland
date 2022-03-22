import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../controllers/image_viewer_controller.dart';

class ImageViewerView extends GetView<ImageViewerController> {
  final String imageAsset = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String thumbUrl =
        'https://bog-ac-static.smartgslb.com/image/thumb/$imageAsset';
    final String largeUrl =
        'https://bog-ac-static.smartgslb.com/image/large/$imageAsset';

    return Scaffold(
        backgroundColor: colorAmber50,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              width: 1.sw,
              height: 1.sh,
              child: ExtendedImage.network(largeUrl,
                  fit: BoxFit.fitWidth,
                  // width: 324.w,
                  mode: ExtendedImageMode.gesture,
                  cache: true,
                  cacheMaxAge: const Duration(hours: 16),
                  initGestureConfigHandler: (state) {
                return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: false,
              initialAlignment: InitialAlignment.center,
                );
              }, loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return ExtendedImage.network(
                  thumbUrl,
                  fit: BoxFit.fitWidth,
                  width: 324.w,
                  cache: true,
                  cacheMaxAge: const Duration(hours: 16),
                );
              case LoadState.completed:
                return null;
              case LoadState.failed:
                return null;
                }
              }),
            ),
            Positioned(
                bottom: 16.h,
                left: 8.w,
                right: 8.w,
                child: TextButton(
                  child: Text('保存图片').fontSize(16.sp).bold().textColor(colorOrange500),
                  onPressed: () {
                    controller.saveImageToLocal(largeUrl);
                  },
                ))
          ],
        ));
    // TODO Download Image function
  }
}
