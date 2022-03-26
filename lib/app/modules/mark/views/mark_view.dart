import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/mark_controller.dart';

class MarkView extends GetView<MarkController> {
  @override
  Widget build(BuildContext context) {
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
    return Obx((() => controller.isMarkListEmpty.value
        ? Center(
            child: SizedBox(
              width: 220.w,
              child: Lottie.asset('assets/lotties/black-cat.json')),
          ).padding(top: 40.h)
        : Container()));
  }

  
}
