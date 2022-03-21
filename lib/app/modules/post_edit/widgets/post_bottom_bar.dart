import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/controllers/content_bottom_bar_controller.dart';
import 'package:bog_island/app/modules/post_edit/controllers/post_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostBottomBar extends GetWidget<PostBottomBarController> {
  const PostBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _barIcon(
          1,
          iconFlowerPath,
        ),
        _barIcon(
          2,
          iconImagePath,
        ),
        _barIcon(
          2,
          iconDeletePath,
        ),
        _barIcon(
          4,
          iconRightPath,
        ),
      ],
    )
        .width(324.w)
        .height(40.h)
        // .padding(left: 20.h, right: 20.h)
        .backgroundColor(colorYellow50);
  }

  Widget _barIcon(int index, String svgPath) {
    return InkWell(
      child: SvgPicture.asset(
        svgPath,
        color: colorNeutral500,
        width: 24.h,
        height: 24.h,
      ),
      onTap: () {
        controller.onBarIconTap(index);
      },
    );
  }
}
