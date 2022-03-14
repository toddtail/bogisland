import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/modules/forum/widgets/topic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0XFF3395F8),
      body: Center(
          child: Obx(
        () => controller.forumTopicList.isEmpty
            ? Container()
            : Column(
                children: [
                  SizedBox(
                    // width: 324.w,
                    height: 44.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('时间线')
                            .fontSize(18.sp)
                            .fontWeight(FontWeight.bold)
                            .textColor(Colors.white),
                        SizedBox(
                            height: 24.w,
                            child: SvgPicture.asset(
                              iconPlanetPath,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  )
                      .padding(left: 12.w, right: 12.w)
                      .backgroundColor(const Color(0XFF3395F8)),
                  Expanded(
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
                            return TopicCard(index);
                          },
                          itemCount: controller.forumTopicList.length,
                          shrinkWrap: true,
                        )),
                  ),
                ],
              ),
      )),
    );
  }
}
