import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget normalTopBar(String text, String iconPath, {int textSize = 18}) {
  return SizedBox(
    // width: 324.w,
    height: 44.h,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text)
            .fontSize(16.sp)
            .fontWeight(FontWeight.bold)
            .textColor(Colors.white),
        SvgPicture.asset(
          iconPath,
          color: Colors.white,
          width: 24.h,
        )
      ],
    ),
  ).padding(left: 12.w, right: 12.w).backgroundColor(colorSky500);
}
