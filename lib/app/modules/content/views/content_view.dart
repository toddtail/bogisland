import 'package:bog_island/app/modules/content/widgets/content_bottom_bar.dart';
import 'package:bog_island/app/modules/content/widgets/content_card.dart';
import 'package:bog_island/app/modules/forum/widgets/topic_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';
import '../controllers/content_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bog_island/app/data/icons_path.dart';

class ContentView extends GetView<ContentController> {
  ContentView();

  final arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.openNewContent(arguments[0]);
    return Scaffold(
      // backgroundColor: const Color(0XFF3395F8),
      backgroundColor: const Color(0xFFFFFEF3),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Obx(
                () => Column(
              children: [
                SizedBox(
                  // width: 324.w,
                  height: 44.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('>>${arguments[0]}')
                          .fontSize(18.sp)
                          .fontWeight(FontWeight.bold)
                          .textColor(Colors.white),
                      SvgPicture.asset(
                        iconPlanetPath,
                        color: Colors.white,
                        width: 24.h,
                      )
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
                                controller.loadContent();
                                
                              }
                              return true;
                            },
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return Hero(
                                    tag: 'forum${arguments[1]}',
                                    child: Material (child: TopicCard(arguments[1])));
                                } else {
                                  return ContentCard(index-1);
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
              child: ContentBottomBar(),)
          ],
        ),
      ),
    );
  }
}
