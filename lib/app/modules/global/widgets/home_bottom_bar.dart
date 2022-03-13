import 'package:bog_island/app/data/icons_path.dart';
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
        _barIcon(iconPlanetPath, () => controller.onBarIconTap(1)),
        _barIcon(iconListBoxPath, () => controller.onBarIconTap(2)),
        _barIcon(iconPenPath, () => controller.onBarIconTap(3)),
        _barIcon(iconSettingsPath, () => controller.onBarIconTap(4))
      ],
    )
        .width(324.w)
        .height(60.h)
        // .padding(left: 20.h, right: 20.h)
        .backgroundColor(const Color(0xFFFFFEF3));
  }
}

Widget _barIcon(String svgPath, VoidCallback function) {
  return InkWell(
    child: SizedBox(
      height: 36.h,
      width: 36.h,
      child: SvgPicture.asset(
        svgPath,
        color: const Color(0xFF545454),
      ),
    ),
    onTap: () => function,
  );
}
