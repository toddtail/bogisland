import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

Widget updateDialog(
    String verisonName, String versionContent, String versionUrl) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
    child: Container(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('更新提示')
            .fontSize(16.sp)
            .bold()
            .textColor(colorNeutral600)
            .padding(bottom: 8.h),
        Text(verisonName)
            .fontSize(14.sp)
            .textColor(colorSky600)
            .padding(bottom: 8.h),
        Text(versionContent)
            .fontSize(14.sp)
            .textColor(colorNeutral900)
            .padding(bottom: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('暂不更新').textColor(colorNeutral600)),
            TextButton(
                onPressed: () async {
                  if (!await launch(versionUrl)) {
                    throw 'Could not launch $versionUrl';
                  }
                },
                child: const Text('前往下载').textColor(colorSky600))
          ],
        )
      ],
    ).padding(all: 12.w)
    ).width(0.5.sw).decorated(
          borderRadius: BorderRadius.all(Radius.circular(8.h)),
        ),
  );
}
