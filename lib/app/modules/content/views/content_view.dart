import 'package:bog_island/app/modules/content/widgets/content_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';
import '../controllers/content_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bog_island/app/data/icons_path.dart';

class ContentView extends GetView<ContentController> {
  ContentView({this.contentId = 0});

  final int contentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0XFF3395F8),
      backgroundColor: const Color(0xFFFFFEF3),
      body: Center(
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
                  Text('>>$contentId')
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
            controller.contentList.isEmpty
                ? Container()
                : Expanded(
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
                            return ContentCard(index);
                          },
                          itemCount: controller.contentList.length,
                          shrinkWrap: true,
                        )),
                  ),
          ],
        ),
      )),
    );
  }
}
