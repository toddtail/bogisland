import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/widgets/normal_top_bar.dart';
import 'package:bog_island/app/modules/post_edit/widgets/emoji_sheet.dart';
import 'package:bog_island/app/modules/post_edit/widgets/image_sheet.dart';
import 'package:bog_island/app/modules/post_edit/widgets/post_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/post_edit_controller.dart';

class PostEditView extends GetView<PostEditController> {
  final arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              normalTopBar('发帖', iconPenPath),
              editor(),
              PostBottomBar(),
              ImageSheet(),
              Obx(() => Offstage(
                  offstage: controller.isEmojiOff.value, child: const EmojiSheet())),
            ],
          ).backgroundColor(colorAmber50),
        ),
      ),
    );
  }

  Widget editor() {
    return Expanded(
      child: SizedBox(
              width: 428.w,
              child: TextField(
                onChanged: (value) {
                  controller.onEditorTextChanged();
                },
                autofocus: true,
                controller: controller.editorController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: '输入文字',
                    hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: colorNeutral400,
                        fontWeight: FontWeight.w300)),
              ))
          .decorated(
            color: colorAmber50,
          )
          .padding(top: 8.h, left: 12.w, right: 12.w),
    );
  }
}
