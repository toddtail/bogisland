import 'package:bog_island/app/modules/forum/views/forum_view.dart';
import 'package:bog_island/app/modules/global/widgets/home_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFFFFFEF3),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: ForumView().width(324.w).height(720.h)),
            Positioned(
              bottom: 0,
              child: HomeBottomBar(),
            )
          ],
        ));
  }
}
