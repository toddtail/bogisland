import 'package:bog_island/app/common/function/time_transfer.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
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
            Text(reply.cookie!).fontSize(12.sp).fontWeight(FontWeight.normal),
            Text(timeTransfer(reply.time!))
                .fontSize(12.sp)
                .fontWeight(FontWeight.normal)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${index + 1}楼')
                .fontSize(12.sp)
                .textColor(const Color(0XFF3395F8)),
            Text('#${reply.id}').fontSize(12.sp)
            // .fontWeight(FontWeight.w500)
          ],
        ).padding(bottom: 4.h),
        contentDisplay(reply.content!),
        // TODO more images
        reply.images == null
            ? Container()
            : Image.network(
                'https://bog-ac-static.smartgslb.com/image/thumb/${reply.images![0].url}${reply.images![0].ext}',
                fit: BoxFit.fitWidth,
                width: 100.h,
                height: 100.h,
              ).padding(top: 4.h),
      ],
    )
        .padding(left: 12.h, right: 12.h, top: 16.h, bottom: 8.h)
        .width(300.h)
        .decorated(color: const Color(0xFFFFFEF3))
        .backgroundColor(
            index == 0 ? const Color(0XFF3395F8) : const Color(0xFFFFFEF3));
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
          )
        },
        onLinkTap: (String? url, RenderContext context,
            Map<String, String> attributes, dom.Element? element) async {
          print('lauch');
          if (!await launch(url!)) throw 'Could not launch $url';
        });
  }
}
