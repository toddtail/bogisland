import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:bog_island/app/modules/setting/bindings/setting_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    SettingBinding().dependencies();
    return Scaffold(
      backgroundColor: colorSky500,
      body: Obx(() => Column(
            children: [normalTopBar('设置', iconSettingsPath), settingsBlock()],
          )).backgroundColor(colorAmber50),
    );
  }

  Widget settingsBlock() {
    return Column(
      children: [
        settingHeader('饼干管理', iconCookiePath, colorOrange400),
        controller.cookieList.isEmpty
            ? Container()
            : Column(
                children: List.generate(controller.cookieList.length, (index) {
                  if (index == 0) {
                    return cookieMaster(controller.cookieList[0].cookie!);
                  } else {
                    return cookieShadow(controller.cookieList[index].cookie!);
                  }
                }),
              ),
        cookieChoice()
      ],
    ).padding(all: 16.h);
  }

  Widget cookieChoice() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            controller.getNewCookie();
          },
          child:
              const Text('生成饼干').fontSize(14.sp).textColor(colorBlue400).bold(),
        ),
        TextButton(
          child: const Text('导入饼干')
              .fontSize(14.sp)
              .textColor(colorGreen400)
              .bold(),
          onPressed: () {
            controller.importCookie();
          },
        ),
      ],
    ).padding(bottom: 8.h);
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
        Text(text).fontSize(16.sp).textColor(colorNeutral600).bold()
      ],
    ).width(300.w).height(36);
  }

  Widget cookieMaster(String cookie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(cookie).bold().textColor(colorNeutral600).fontSize(14.sp),
        SvgPicture.asset(
          iconDeletePath,
          width: 20.h,
          color: colorRed300,
        ).gestures(onTap: (() {
          controller.removeMasterCookie();
        }))
      ],
    ).width(300.w).height(36).padding(top: 4.h, left: 8.w, right: 8.w);
  }

  Widget cookieShadow(String cookie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(cookie).textColor(colorNeutral500).fontSize(14.sp),
        SvgPicture.asset(
          iconDeletePath,
          width: 20.h,
          color: colorRed300,
        ).gestures(onTap: () {
          controller.removeShadowCookie(cookie);
        })
      ],
    ).width(300.w).height(36).padding(top: 4.h, left: 8.w, right: 8.w);
  }
}
