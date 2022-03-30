import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/forum/views/forum_view.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
import 'package:bog_island/app/modules/global/widgets/forum_select_card.dart';
import 'package:bog_island/app/modules/global/widgets/home_bottom_bar.dart';
import 'package:bog_island/app/modules/global/widgets/keep_alive_wrapper.dart';
import 'package:bog_island/app/modules/mark/views/mark_view.dart';
import 'package:bog_island/app/modules/setting/views/setting_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../controllers/home_controller.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends GetView<HomeController> {
  final homeBottomBarController = Get.find<HomeBottomBarController>();

  @override
  Widget build(BuildContext context) {
    controller.activeController();
    return Scaffold(
        backgroundColor: colorSky500,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: PageView(
                controller: homeBottomBarController.pageController,
                children: [
                  KeepAliveWrapper(child: ForumView()),
                  KeepAliveWrapper(child: MarkView()),
                  KeepAliveWrapper(child: SettingView())
                ],
                onPageChanged: (index) {
                  homeBottomBarController.onPageChanged(index);
                },
              ).width(324.w).height(1.sh-60.h+1.h),
            ),
            const Positioned(
              bottom: 0,
              child: HomeBottomBar(),
            ),
          ],
        ));
  }
}
