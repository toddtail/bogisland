import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/widgets/content_bottom_bar.dart';
import 'package:bog_island/app/modules/content/widgets/content_card.dart';
import 'package:bog_island/app/modules/content/widgets/content_slivers.dart';
import 'package:bog_island/app/modules/forum/widgets/topic_card.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:styled_widget/styled_widget.dart';
import '../controllers/content_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bog_island/app/data/icons_path.dart';

class ContentView extends GetView<ContentController> {
  ContentView();

  final ContentArgumentModel arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.openNewContent(arguments);

    return Scaffold(
      backgroundColor: colorSky500,
      // backgroundColor: colorAmber50,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Column(
                children: [
                  normalTopBar(
                      '>>Po.${controller.topicId.value}', iconPlanetPath,
                      textSize: 16),
                  Expanded(
                      child: Obx(() => controller.isOnLoad.value &&
                              controller.contentList.isEmpty
                          ? loadingAnimationWidiget()
                          : NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                              // bottom
                              if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                                controller.loadContent(LoadMode.bottom);
                              }
                              // top
                              else if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.minScrollExtent) {
                                controller.loadContent(LoadMode.top);
                              }
                              return true;
                            }, child:
                                  CustomScrollView(
                                    center: controller.centerKey,
                                    slivers: [
                                      ContentSlivers(false),
                                      ContentSlivers(true, key: controller.centerKey),
                                    ],
                                  )))),
                ],
              )
                  .width(324.w)
                  .height(1.sh - 40.h - MediaQuery.of(context).padding.top),
            ),
            const Positioned(
              bottom: 0,
              child: ContentBottomBar(),
            )
          ],
        ).backgroundColor(colorAmber50),
      ),
    );
  }

  Widget headThreadWithHero() {
    return Hero(
            tag: '${controller.topicId}${controller.heroTagAddition.value}',
            child: Material(child: ContentCard(0)))
        .width(324.w);
  }

  Widget loadingAnimationWidiget() {
    return Container(
      alignment: Alignment.topCenter,
      child: Lottie.asset(
        'assets/lotties/load-topic.json',
        width: 160.w,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
