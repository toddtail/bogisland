import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForumSelectCard extends GetWidget<HomeBottomBarController> {
  ForumSelectCard({Key? key}) : super(key: key);

  final forumListController = Get.find<ForumListController>();
  final forumController = Get.find<ForumController>();
  final homeBottomBarController = Get.find<HomeBottomBarController>();

  @override
  Widget build(BuildContext context) {
    // TODO use Wrap replace
    return Obx((() => Container(
                child: GridView.count(
          crossAxisCount: 5,
          childAspectRatio: (30 / 20),
          children: List.generate(
              forumListController.fullForumList.length,
              (index) => forumCell(
                  forumListController.fullForumList[index].name!,
                  forumListController.fullForumList[index].id!)),
        ))
            .decorated(
              // boxShadow: [
              //   BoxShadow(
              //       color: const Color(0xFFF6F5E0),
              //       offset: Offset(0, -8.h),
              //       blurRadius: 12)
              // ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.h),
                topRight: Radius.circular(24.h),
              ),
              // color: const Color(0xFFFFFEF3),
            )
            .width(324.w)
            .height(164.h)
            .backgroundColor(const Color(0xFFFFFEF3))));
  }

  Widget forumCell(String text, int id) {
    return Container(
      alignment: Alignment.center,
      child: Text(text).fontSize(12.sp).textColor(Colors.white).bold(),
    )
        .width(84.h)
        .decorated(
            borderRadius: BorderRadius.all(Radius.circular(8.h)),
            color: id != forumController.selectedForumId.value
                ? const Color(0XFF3395F8)
                : const Color(0XFF33F8A5))
        .padding(bottom: 8.h, top: 8.h, left: 4.h, right: 4.h)
        .gestures(onTap: () {
      forumController.reloadTopic(id);
      homeBottomBarController.onTopicCellTaped();
    });
  }
}
