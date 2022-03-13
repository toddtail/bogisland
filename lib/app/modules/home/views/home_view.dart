import 'package:bog_island/app/modules/global/widgets/home_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFFFFFEF3),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: HomeBottomBar(),
            )
          ],
        ));
  }
}
