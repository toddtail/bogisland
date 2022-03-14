import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/forum/models/forum_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

class TopicCard extends GetWidget<ForumController> {
  const TopicCard(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final Info info = controller.forumTopicList[index];

    return Container(
      child: Column(
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
              Text('综合版')
                  .textColor(const Color(0XFF1281EC))
                  .fontSize(12.sp)
                  .fontWeight(FontWeight.w500)
                  .padding(bottom: 4.h),
              Text('#${info.id}')
                  .fontSize(12.sp)
                  .fontWeight(FontWeight.w500)
                  .padding(bottom: 4.h),
            ],
          ),
          contentDisplay(info.content!),
          info.images == null
              ? Container()
              : Image.network(
                  'https://bog-ac-static.smartgslb.com/image/thumb/${info.images![0].url}${info.images![0].ext}',
                  fit: BoxFit.fitWidth,
                  width: 100.h,
                  height: 100.h,
                ).padding(bottom: 4.h)
        ],
      ).padding(all: 8.h),
    )
        .width(300.h)
        .padding(bottom: 8.h)
        .backgroundColor(const Color(0xFFFFFEF3));
  }

  Widget contentDisplay(String text) {
    // TODO
    text = text.replaceAll('<br />', '\n');
    return Text(
      text,
      maxLines: 15,
      overflow: TextOverflow.ellipsis,
    ).fontSize(12.sp).fontWeight(FontWeight.w500);
  }
}
