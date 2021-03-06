import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
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
    return Obx((() => Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
                forumListController.fullForumList.length,
                (index) => forumListController.fullForumList[index].hide!
                    ? const SizedBox.shrink()
                    : forumCell(forumListController.fullForumList[index].name!,
                        forumListController.fullForumList[index].id!)))
        .decorated(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.h),
            topRight: Radius.circular(24.h),
          ),
          // color: colorAmber50,
        )
        .width(324.w)
        .padding(top: 8.h, bottom: 8.h)
        // .height(380.h)
        .backgroundColor(colorAmber50)));
  }

  Widget forumCell(String text, int id) {
    return Container(
      alignment: Alignment.center,
      child: Text(text).fontSize(12.sp).textColor(Colors.white).bold(),
    )
        .width(60.h)
        .height(24.h)
        .decorated(
            borderRadius: BorderRadius.all(Radius.circular(8.h)),
            color: id != forumController.selectedForumId.value
                ? colorSky500
                : const Color(0XFF33F8A5))
        .padding(bottom: 8.h, top: 8.h, left: 8.h, right: 8.h)
        .gestures(onTap: () {
      forumController.reloadTopic(id);
      homeBottomBarController.onTopicCellTaped();
      Get.back();
    });
  }
}
