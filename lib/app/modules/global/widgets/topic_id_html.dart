import 'package:bog_island/app/common/function/time_transfer.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/global/providers/topic_id_html_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

CustomRenderMatcher quoteMatcher() => (context) {
      return context.tree.attributes['class'] == 'quote';
    };

class TopicIdInHtml extends GetWidget<TopicIdHtmlController> {
  TopicIdInHtml(this.idWithPo);

  final String idWithPo;
  String _loadingWords = '内容加载中...';
  String _failedWords = '加载失败';

  @override
  Widget build(BuildContext context) {
    String id = idWithPo.split('.')[1];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(idWithPo).fontSize(14.sp).textColor(colorNeutral500).gestures(
            onTap: () {
          if (!controller.threadLoadedMap.containsKey(id)) {
            controller.loadIdThread(id);
          }
        }),
        Obx(() {
          if (controller.threadLoadedMap.containsKey(id)) {
            if (controller.threadLoadedMap[id] == 'loading') {
              return const Text('内容加载中...')
                  .textColor(colorSky600)
                  .padding(bottom: 4.h);
            } else if (controller.threadLoadedMap[id] == 'failed') {
              return const Text('加载失败')
                  .textColor(colorRed500)
                  .padding(bottom: 4.h);
            } else {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(controller.threadLoadedMap[id][0])
                          .fontSize(12.sp)
                          .fontWeight(FontWeight.normal)
                          .textColor(colorNeutral500)
                          .padding(right: 8.w),
                      Text(timeTransfer(controller.threadLoadedMap[id][1]))
                          .fontSize(12.sp)
                          .fontWeight(FontWeight.normal)
                          .textColor(colorNeutral500)
                    ],
                  ),
                  Html(
                    data: controller.threadLoadedMap[id][2],
                    shrinkWrap: true,
                    style: {
                      'body': Style(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          fontSize: FontSize(14.sp),
                          color: colorNeutral900)
                    },
                    customRenders: {
                      quoteMatcher():
                          CustomRender.widget(widget: (context, buildChildren) {
                        // print(context.tree.children[0].toString().replaceAll('"', ''));
                        return TopicIdInHtml(context.tree.children[0]
                            .toString()
                            .replaceAll('"', ''));
                      })
                    },
                  )
                ],
              )
                  .padding(left: 8.w, bottom: 4.h, top: 4.h)
                  .width(0.9.sw)
                  .border(left: 2.h, color: colorNeutral400);
            }
          } else {
            return const SizedBox.shrink();
          }
        })
      ],
    );
  }
}
