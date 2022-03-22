import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget imageCell(String imageAsset) {
  return ExtendedImage.network(
    'https://bog-ac-static.smartgslb.com/image/thumb/$imageAsset',
    fit: BoxFit.fitWidth,
    width: 0.25.sw,
    height: 0.25.sw,
    cache: true,
    cacheMaxAge: const Duration(hours: 16),
  ).padding(all: 4.w).gestures(onTap: () {
    Get.toNamed("/image-viewer", arguments: imageAsset);
  });
}
