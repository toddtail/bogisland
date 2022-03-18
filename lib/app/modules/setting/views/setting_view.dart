import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAmber50,
      body: Column(
        children: [normalTopBar('设置', iconSettingsPath), settings()],
      ),
    );
  }

  Widget settings() {
    return Column(
      children: [settingHeader('饼干管理', iconCookiePath, colorOrange400)],
    ).padding(all: 16.h);
  }

  Widget settingHeader(String text, String iconPath, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 28.h,
          color: color,
        ).padding(right: 12.w),
        Text(text).fontSize(18.sp).textColor(colorNeutral600).bold()
      ],
    ).width(300.w).height(36);
  }
}
