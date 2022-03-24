import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/widgets/content_bottom_bar.dart';
import 'package:bog_island/app/modules/content/widgets/content_card.dart';
import 'package:bog_island/app/modules/forum/widgets/topic_card.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
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
      // backgroundColor: colorSky500,
      backgroundColor: colorAmber50,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Obx(
                () => Column(
                  children: [
                    normalTopBar('>>Po.${controller.topicId.value}', iconPlanetPath,
                        textSize: 16),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              controller.loadContent();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              Widget headThread = Hero(
                                  tag: 'forum${controller.topicIndexInForum.value}',
                                  child: Material(
                                      child: TopicCard(
                                    controller.topicIndexInForum.value,
                                    isInContent: true,
                                  ))).width(324.w);
                              if (index == 0 &&
                                  controller.contentList.isNotEmpty) {
                                return headThread;
                              } else if (index == 0 &&
                                  controller.contentList.isEmpty) {
                                return Wrap(
                                  children: [
                                    headThread,
                                    controller.isOnLoad.value
                                        ? Container(
                                            alignment: Alignment.topCenter,
                                            child: Lottie.asset(
                                              'assets/lotties/load-topic.json',
                                              width: 160.w,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              } else {
                                return ContentCard(index - 1);
                              }
                            },
                            itemCount: controller.contentList.length + 1,
                            shrinkWrap: true,
                          )),
                    ),
                  ],
                ).width(324.w).height(656.h),
              ),
            ),
            const Positioned(
              bottom: 0,
              child: ContentBottomBar(),
            )
          ],
        ),
      ),
    );
  }
}
