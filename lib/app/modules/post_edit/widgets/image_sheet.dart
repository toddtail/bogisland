import 'package:bog_island/app/data/icons_path.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/post_edit/controllers/post_edit_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:io' show File;

class ImageSheet extends GetWidget<PostEditController> {
  const ImageSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    controller.selectedImageXFileList.length + 1, (index) {
                  if (index == 0) {
                    return addButton();
                  } else {
                    return imageBlock(index - 1);
                  }
                }),
              ).padding(left: 16.w);
            },
          )),
    ).width(1.sw).height(0.25.sh).backgroundColor(colorAmber100);
  }

  Widget addButton() {
    return Container(
      child: SizedBox(
        width: 40.w,
        height: 40.w,
        child: controller.onImageLoad.value
            ? Lottie.asset('assets/lotties/uploading.json')
            : SvgPicture.asset(
                iconImageAddPath,
                color: colorNeutral500,
              ),
      ).paddingAll(16.w).decorated(
          borderRadius: BorderRadius.circular(4.w), color: Colors.white)
      // .backgroundColor(Colors.white)
      ,
    ).gestures(onTap: () async {
      if (!controller.onImageLoad.value) {
        await controller.pickImageAndUpload();
      }
    });
  }

  Widget imageBlock(int index) {
    XFile image = controller.selectedImageXFileList[index];
    return Stack(
      children: [
        Positioned(
            top: 10.w,
            left: 10.w,
            child: Image.file(
              File(image.path),
              width: 100.w,
              height: 100.w,
              fit: BoxFit.fitWidth,
            ).backgroundColor(colorAmber50)),
        Positioned(
            right: 0,
            bottom: 0,
            child: Material(
              child: InkWell(
                onTap: (() {
                  controller.removeSelectedImage(index);
                }),
                child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: SvgPicture.asset(
                      iconDeletePath,
                      color: colorNeutral400,
                    )).padding(all: 4.w),
              ),
            ).clipOval())
      ],
    ).width(120.w).height(120.w).padding(left: 4.w, right: 4.w);
  }
}
