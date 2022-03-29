import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:bog_island/app/modules/mark/bindings/mark_binding.dart';
// import 'package:bog_island/app/modules/mark/widgets/mark_card.dart';
import 'package:bog_island/app/modules/mark/widgets/mark_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/mark_controller.dart';

class MarkView extends GetView<MarkController> {
  @override
  Widget build(BuildContext context) {
    MarkBinding().dependencies();

    return Scaffold(
      backgroundColor: colorSky500,
      body: SafeArea(
          child: Column(
        children: [
          normalTopBar(
            '收藏',
            iconHeartPath,
          ),
          _markView()
        ],
      ).backgroundColor(colorAmber50)),
    );
  }

  Widget _markView() {
    return Obx((() => controller.markTopicList.isEmpty
        ? Center(
            child: SizedBox(
                width: 220.w,
                child: Lottie.asset('assets/lotties/black-cat.json')),
          ).padding(top: 40.h)
        : Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Hero(
                    tag: '${controller.markTopicList[index].id!}mark',
                    child: MarkCard(index));
              },
              itemCount: controller.markTopicList.length,
              shrinkWrap: true,
            ),
          )));
  }
}
