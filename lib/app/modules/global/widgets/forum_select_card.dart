import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForumSelectCard extends GetWidget<HomeBottomBarController> {
  const ForumSelectCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container().decorated(
      boxShadow: [
        BoxShadow(
            color: const Color(0xFFF6F5E0),
            offset: Offset(0, -8.h),
            blurRadius: 24.h)
      ],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.h),
        topRight: Radius.circular(24.h),
      ),
      color: const Color(0XFFFFFEF3),
    ).width(324.w).height(164.h);
  }
}
