import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/post_edit/controllers/post_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

class CookieChoiceSheet extends GetWidget<PostEditController> {
  const CookieChoiceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((() {
      return Container(
              child: Wrap(
        children: List.generate(
            controller.readCookieList().length,
            (index) => Text(controller.readCookieList()[index].cookie!, textAlign: TextAlign.center,)
                    .textColor(index == controller.cookieIndexSelectedForPost.value
                        ? colorSky600
                        : colorNeutral600)
                    .fontSize(20.sp).bold()
                    .width(1.sw)
                    .height(32.h)
                    .padding(top: 4.h)
                    .gestures(onTap: () {
                  controller.setCookieSelectedForPost(index);
                  Get.back();
                })),
      ))
          .width(1.sw)
          // .height(0.3.sh)
          .decorated(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.h),
              topRight: Radius.circular(24.h),
            ),
            // color: colorAmber50,
          )
          .backgroundColor(colorAmber100);
    }));
  }
}
