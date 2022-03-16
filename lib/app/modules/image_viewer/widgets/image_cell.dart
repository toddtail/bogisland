import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ImageCell(String url) {
    return ExtendedImage.network(
                'url',
                fit: BoxFit.fitWidth,
                width: 100.h,
                height: 100.h,
                cache: true,
                cacheMaxAge: const Duration(hours: 16),
              ).padding(all: 4.h);
  }