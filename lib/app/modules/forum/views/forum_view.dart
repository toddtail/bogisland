import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/forum/bindings/forum_binding.dart';
import 'package:bog_island/app/modules/forum/widgets/topic_card.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  final forumListController = Get.find<ForumListController>();

  @override
  Widget build(BuildContext context) {
    ForumBinding().dependencies();
    return Scaffold(
      backgroundColor: colorSky500,
      // backgroundColor: colorAmber50,
      body: SafeArea(
        child: Center(
            child: Obx(
          () => Column(
            children: [
              normalTopBar(
                controller.forumTopicList.isEmpty
                    ? ''
                    : forumListController
                        .liteForumMap[controller.selectedForumId.value],
                iconPlanetPath,
              ),
              controller.forumTopicList.isEmpty
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 60.h),
                        child: Lottie.asset(
                          'assets/lotties/salad-cat.json',
                          width: 160.w,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                          .decorated(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.h),
                                topRight: Radius.circular(24.h),
                              ),
                              color: colorAmber50)
                          .backgroundColor(colorSky500)
                          .width(324.w),
                    )
                  : Expanded(
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              controller.loadTopic();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Hero(
                                  tag: '${controller.forumTopicList[index].id}forum',
                                  child: Material(child: TopicCard(index)));
                            },
                            itemCount: controller.forumTopicList.length,
                            shrinkWrap: true,
                          )),
                    ),
            ],
          ),
        )).backgroundColor(colorAmber50),
      ),
    );
  }
}
