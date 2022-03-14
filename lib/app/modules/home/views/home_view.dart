import 'package:bog_island/app/modules/forum/views/forum_view.dart';
import 'package:bog_island/app/modules/global/controller/home_bottom_bar_controller.dart';
import 'package:bog_island/app/modules/global/widgets/forum_select_card.dart';
import 'package:bog_island/app/modules/global/widgets/home_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends GetView<HomeController> {
  final homeBottomBarController = Get.find<HomeBottomBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF3395F8),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(top: 0, child: ForumView().width(324.w).height(720.h)),
              Obx(() => AnimatedPositioned(
                  bottom: homeBottomBarController.isOnForumSelect.value
                      ? 59.h
                      : -165.h,
                  child: ForumSelectCard(),
                  curve: Curves.bounceInOut,
                  duration: const Duration(milliseconds: 200))),
              const Positioned(
                bottom: 0,
                child: HomeBottomBar(),
              ),
            ],
          ),
        ));
  }
}
