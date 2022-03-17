import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ImageCell(String imageAsset) {
  return ExtendedImage.network(
    'https://bog-ac-static.smartgslb.com/image/thumb/$imageAsset',
    fit: BoxFit.fitWidth,
    width: 100.h,
    height: 100.h,
    cache: true,
    cacheMaxAge: const Duration(hours: 16),
  ).padding(all: 4.h).gestures(onTap: () {
    Get.toNamed("/image-viewer", arguments: imageAsset);
  });
}
