import 'package:bog_island/app/common/function/time_transfer.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/image_viewer/widgets/image_cell.dart';
import 'package:bog_island/app/modules/mark/controllers/mark_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarkCard extends StatelessWidget {
  MarkCard(this.index, {Key? key}) : super(key: key);

  final int index;
  final forumListController = Get.find<ForumListController>();
  final controller = Get.find<MarkController>();

  @override
  Widget build(BuildContext context) {
    final TopicInfo topicInfo = controller.markTopicList[index];
    Logger().i('MarkCard build: $index');
    // Logger().i('MarkCard build: ${topicInfo.content}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(topicInfo.cookie!)
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
                .textColor(colorSlate500),
            Text(timeTransfer(topicInfo.time!))
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
                .textColor(colorSlate500),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(forumListController.liteForumMap[topicInfo.forum])
                .textColor(const Color(0XFF1281EC))
                .fontSize(12.sp)
                .fontWeight(FontWeight.w500),
            Text('#${topicInfo.id}').fontSize(12.sp).textColor(colorSlate400),
            // .fontWeight(FontWeight.w500)
          ],
        ).padding(bottom: 4.h),
        contentDisplay(topicInfo.content!),
        topicInfo.images == null
            ? Container()
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                    topicInfo.images!.length,
                    (index) => imageCell(
                        '${topicInfo.images![index].url}${topicInfo.images![index].ext}')),
              ).width(0.9.sw),
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
            color: colorAmber50)
        .backgroundColor(index == 0 ? colorSky500 : colorAmber50)
        .gestures(onTap: () {
      controller.jumpToContent(index);
    });
  }

  Widget contentDisplay(String text) {
    return Html(
      data: text,
      shrinkWrap: true,
      style: {
        'body': Style(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            fontSize: FontSize(14.sp),
            maxLines: 15,
            textOverflow: TextOverflow.ellipsis,
            color: colorSlate900)
      },
    );
  }
}
