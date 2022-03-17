import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        body: Center(
            child: ExtendedImage.network(largeUrl,
                fit: BoxFit.fitWidth,
                width: 324.w,
                cache: true,
                cacheMaxAge: const Duration(hours: 16),
                loadStateChanged: (ExtendedImageState state) {
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
              //TODO 加载失败提示
              return null;
          }
        })));
        // TODO Download Image function
  }
}
