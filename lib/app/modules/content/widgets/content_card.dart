import 'package:bog_island/app/common/function/time_transfer.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/global/widgets/topic_id_html.dart';
import 'package:bog_island/app/modules/image_viewer/widgets/image_cell.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class ContentCard extends GetWidget<ContentController> {
  ContentCard(this.index, {Key? key}) : super(key: key);

  final int index;
  final forumListController = Get.find<ForumListController>();

  //TODO PO symbol

  @override
  Widget build(BuildContext context) {
    final Reply reply = controller.contentList[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(reply.cookie!)
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
                .textColor(colorSlate500),
            Text(timeTransfer(reply.time!))
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
                .textColor(colorSlate500)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${index + 1}楼').fontSize(12.sp).textColor(colorSky500),
            Text('#${reply.id}')
                .fontSize(12.sp)
                .textColor(colorSlate400)
                .gestures(onTap: () {
              Get.toNamed('/post-edit',
                  arguments: PostArgumentModel(
                      isNewPost: false,
                      quoteId: reply.id,
                      topicId: controller.topicId.value));
            })
            // .fontWeight(FontWeight.w500)
          ],
        ).padding(bottom: 4.h),
        contentDisplay(reply.content!),
        // TODO more images
        reply.images == null
            ? Container()
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                    reply.images!.length,
                    (index) => imageCell(
                        '${reply.images![index].url}${reply.images![index].ext}')),
              ).width(0.9.sw),
      ],
    )
        .padding(left: 12.h, right: 12.h, top: 16.h, bottom: 8.h)
        .width(300.h)
        .decorated(color: colorAmber50)
        .backgroundColor(index == 0 ? colorSky500 : colorAmber50);
  }

  Widget contentDisplay(String text) {
    // TODO url clicked, id display
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
        if (!await launch(url!)) throw 'Could not launch $url';
      },
      customRenders: {
        quoteMatcher(): CustomRender.widget(widget: (context, buildChildren) {
          // Logger().i(context.tree.children[0].toString().replaceAll('"', ''));
          return TopicIdInHtml(
              context.tree.children[0].toString().replaceAll('"', ''));
        })
      },
    );
  }
}
