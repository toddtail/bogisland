import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomBar extends GetWidget<HomeBottomBarController> {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _barIcon(
          1,
          iconPlanetPath,
        ),
        _barIcon(
          2,
          iconListBoxPath,
        ),
        _barIcon(
          3,
          iconHeartPath,
        ),
        _barIcon(
          4,
          iconPenPath,
        ),
        _barIcon(
          5,
          iconSettingsPath,
        )
      ],
    )
        .width(324.w)
        .height(60.h)
        // .padding(left: 20.h, right: 20.h)
        .backgroundColor(colorYellow50);
  }
}

Widget _barIcon(int index, String svgPath) {
  final controller = Get.find<HomeBottomBarController>();

  return Obx(() => InkWell(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCirc,
      height: !controller.iconSelectedState[index - 1] ? 32.h : 40.h,
      width: !controller.iconSelectedState[index - 1] ? 32.h : 40.h,
      child: SvgPicture.asset(
        svgPath,
        color: !controller.iconSelectedState[index - 1] ? colorNeutral500 : colorSky500,
      ),
    ),
    onTap: () => controller.onBarIconTap(index),
    onDoubleTap: () => controller.onBarIconDoubleTap(index),
  ));
}
