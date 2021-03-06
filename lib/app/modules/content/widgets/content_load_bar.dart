import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';

Widget topLoadingBar() {
  final contentController = Get.find<ContentController>();

  return SliverList(
    delegate: SliverChildListDelegate([
      Obx(() => contentController.topPage.value == 1
          ? const SizedBox.shrink()
          : SizedBox(
              width: 1.sh,
              height: 0.08.sh,
              child: Lottie.asset('assets/lotties/dino-loading.json'),
            ))
    ]),
  );
}

Widget bottomLoadingBar() {
  final contentController = Get.find<ContentController>();

  return SliverList(
    delegate: SliverChildListDelegate([
      Obx(() => contentController.bottomPage.value ==
              contentController.totalPage.value
          ? contentController.isOnLoad.value
              ? SizedBox(
                  width: 1.sh,
                  height: 0.08.sh,
                  child: Lottie.asset('assets/lotties/bottom-loading.json'),
                )
              : Container(
                  width: 1.sh,
                  height: 0.04.sh,
                  alignment: Alignment.center,
                  child: const Text('[ ›´ω`‹ ]到底了,点击加载更新')
                      .fontSize(12.sp)
                      .textColor(colorSky400)
                      .textAlignment(TextAlign.center),
                ).gestures(onTap: () {
                  contentController.loadContentAtBottom();
                })
          : SizedBox(
              width: 1.sh,
              height: 0.08.sh,
              child: Lottie.asset('assets/lotties/bottom-loading.json'),
            ))
    ]),
  );
}
