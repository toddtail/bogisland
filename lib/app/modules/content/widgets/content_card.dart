import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/forum/models/forum_model.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentCard extends GetWidget<ContentController> {
  ContentCard(this.index, {Key? key}) : super(key: key);

  final int index;
  final forumListController = Get.find<ForumListController>();

  //TODO po icon

  @override
  Widget build(BuildContext context) {
    final Info info = controller.contentList[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(info.cookie!).fontSize(12.sp).fontWeight(FontWeight.normal),
            Text(info.root!).fontSize(12.sp).fontWeight(FontWeight.normal)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TODO
            Text(forumListController.liteForumMap[info.forum])
                .textColor(const Color(0XFF1281EC))
                .fontSize(12.sp)
                .fontWeight(FontWeight.w500),
            Text('#${info.id}').fontSize(12.sp)
            // .fontWeight(FontWeight.w500)
          ],
        ).padding(bottom: 4.h),
        contentDisplay(info.content!),
        info.images == null
            ? Container()
            : Image.network(
                'https://bog-ac-static.smartgslb.com/image/thumb/${info.images![0].url}${info.images![0].ext}',
                fit: BoxFit.fitWidth,
                width: 100.h,
                height: 100.h,
              ).padding(top: 4.h)
      ],
    )
        .padding(left: 12.h, right: 12.h, top: 16.h, bottom: 8.h)
        .width(300.h)
        .decorated(
            borderRadius: index == 0
                ? BorderRadius.only(
                    topLeft: Radius.circular(24.h),
                    topRight: Radius.circular(24.h),
                  )
                : null,
            color: const Color(0xFFFFFEF3))
        .backgroundColor(
            index == 0 ? const Color(0XFF3395F8) : const Color(0xFFFFFEF3));
  }

  Widget contentDisplay(String text) {
    // TODO url clicked
    return Html(
      data: text,
      shrinkWrap: true,
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          fontSize: FontSize(12.sp),
          maxLines: 15,
          textOverflow: TextOverflow.ellipsis,
        )
      },
    );
  }
}
