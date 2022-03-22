import 'package:bog_island/app/common/function/time_transfer.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/forum/models/forum_model.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/global/widgets/topic_id_html.dart';
import 'package:bog_island/app/modules/image_viewer/widgets/image_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class TopicCard extends GetWidget<ForumController> {
  TopicCard(this.index, {this.isInContent = false, Key? key}) : super(key: key);

  final int index;
  final bool isInContent;
  final forumListController = Get.find<ForumListController>();

  @override
  Widget build(BuildContext context) {
    final Info info = controller.forumTopicList[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(info.cookie!)
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
                .textColor(colorSlate500),
            Text(timeTransfer(info.time!))
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
                .textColor(colorSlate500),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(forumListController.liteForumMap[info.forum])
                .textColor(const Color(0XFF1281EC))
                .fontSize(12.sp)
                .fontWeight(FontWeight.w500),
            Text('#${info.id}').fontSize(12.sp).textColor(colorSlate400),
            // .fontWeight(FontWeight.w500)
          ],
        ).padding(bottom: 4.h),
        contentDisplay(info.content!),
        info.images == null
            ? Container()
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                    info.images!.length,
                    (index) => imageCell(
                        '${info.images![index].url}${info.images![index].ext}')),
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
    if (!isInContent) {
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
    } else {
      return Html(
        data: text,
        shrinkWrap: true,
        style: {
          'body': Style(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              fontSize: FontSize(14.sp),
              color: colorSlate900)
        },
        onLinkTap: (String? url, RenderContext context,
            Map<String, String> attributes, dom.Element? element) async {
          print('lauch');
          if (!await launch(url!)) throw 'Could not launch $url';
        },
        customRenders: {
          quoteMatcher(): CustomRender.widget(widget: (context, buildChildren) {
            // print(context.tree.children[0].toString().replaceAll('"', ''));
            return TopicIdInHtml(
                context.tree.children[0].toString().replaceAll('"', ''));
          })
        },
      );
    }
  }
}
