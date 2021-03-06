import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/controllers/content_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentBottomBar extends GetWidget<ContentBottomBarController> {
  const ContentBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => _barIcon(1, iconHeartPath,
              color: controller.isTopicMarked.value
                  ? colorRose500
                  : colorSlate500),
        ),
        _barIcon(
          2,
          iconPenPath,
        ),
        _barIcon(
          3,
          iconFloorPath,
        ),
        Obx(
          () => _barIcon(4, iconEyeLinePath,
              color: controller.isOnlyPoDisplay.value
                  ? colorTeal400
                  : colorSlate500),
        )
        // TODO
        // _barIcon(
        //   4,
        //   iconSharePath,
        // ),
      ],
    )
        .width(324.w)
        .height(40.h)
        // .padding(left: 20.h, right: 20.h)
        .backgroundColor(colorYellow50);
  }

  Widget _barIcon(int index, String svgPath, {Color color = colorSlate500}) {
    return InkWell(
      child: SvgPicture.asset(
        svgPath,
        color: color,
        width: 24.h,
        height: 24.h,
      ),
      onTap: () => controller.onBarIconTap(index),
    );
  }
}
