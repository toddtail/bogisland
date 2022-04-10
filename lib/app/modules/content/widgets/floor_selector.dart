import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:resonance/resonance.dart';
import 'package:styled_widget/styled_widget.dart';

class FloorSelector extends GetView<ContentController> {
  const FloorSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('楼层跳转')
                    .fontSize(18.sp)
                    .textColor(colorNeutral600)
                    .bold(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28.w,
                        // height: 24.h,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: controller.floorEditingController,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: colorNeutral900,
                                fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            )),
                      )
                          .padding(left: 4.w, right: 4.w)
                          .border(color: colorNeutral200, all: 1.w)
                          .padding(right: 4.w),
                      Text('/${controller.totalPage.value}')
                          .fontSize(16.sp)
                          .textColor(colorNeutral900)
                          .padding(right: 8.w),
                      floorScroller(),
                    ],
                  ).width(1.sh),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 1.sh,
                  child: TextButton(
                      onPressed: () {
                        controller.onFloorJumpTapped();
                      },
                      child: Text('跳转楼层').textColor(colorSky400).fontSize(14.sp)),
                )
              ],
            ).padding(all: 8.w)))
        .width(1.sh)
        .height(0.2.sh)
        .backgroundColor(colorAmber50);
  }

  Widget floorScroller() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        ScrollDirection direction =
            controller.floorWheelController.position.userScrollDirection;
        controller.changeFloorSelection(direction);
        return true;
      },
      child: ListWheelScrollView.useDelegate(
        controller: controller.floorWheelController,
        itemExtent: 8.h,
        diameterRatio: 0.8,
        perspective: 0.005,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) async {
          try {
            await Resonance.vibrate(duration: const Duration(milliseconds: 10));
          } catch (e) {
            print(e);
          }
        },
        childDelegate: ListWheelChildLoopingListDelegate(
            children: List.generate(
                18,
                (index) => Divider(
                      color: colorSky400,
                      thickness: 8.h,
                    ))),
      ).width(20.w).height(52.h),
    );
  }
}
