import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBottomBar extends GetWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container()
        .width(324.w)
        .height(60.h)
        .backgroundColor(Color(0xFFFFFEF3));
  }
}

Widget _barIcon() {
  return InkWell(
    
  );
}
