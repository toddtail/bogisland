import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/content/widgets/content_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';

class ContentSlivers extends StatelessWidget {
  ContentSlivers(this.isPositive, {Key? key}) : super(key: key);
  final controller = Get.find<ContentController>();
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    if (isPositive) {
      return positiveSlivers();
    } else {
      return negativeSlivers();
    }
  }

  // Widget positiveSlivers() {
  //   return SliverList(
  //       delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //     return ContentCard(index);
  //   }, childCount: controller.contentList.length));
  // }

  Widget positiveSlivers() {
    return SliverList(
        key: key,
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return controller.isOnLoad.value
              ? controller.contentList.length == 1
                  ? Wrap(
                      children: [
                        headThreadWithHero(),
                        loadingAnimationWidiget()
                      ],
                    )
                  : controller.contentList[index].floor == 1
                      ? headThreadWithHero()
                      : ContentCard(index)
              : controller.contentList[index].floor == 1
                  ? headThreadWithHero()
                  : ContentCard(index);
        }, childCount: controller.contentList.length));
  }

  Widget negativeSlivers() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      Logger().i('negativeSlivers: index $index floor ${controller.contentNegativeList[index].floor}');
      return controller.isOnLoad.value
          ? controller.contentNegativeList.length == 1
              ? Wrap(
                  children: [
                    headThreadWithHero(isPositive: false),
                    loadingAnimationWidiget()
                  ],
                )
              : controller.contentNegativeList[index].floor == 1
                  ? headThreadWithHero(isPositive: false)
                  : ContentCard(
                      // controller.contentNegativeList.length-1-index,
                      index,
                      isPositive: false,
                    )
          : controller.contentNegativeList[index].floor == 1
              ? headThreadWithHero(isPositive: false)
              : ContentCard(
                // controller.contentNegativeList.length-1-index, 
                index,
                isPositive: false);
    }, childCount: controller.contentNegativeList.length));
  }

  Widget headThreadWithHero({bool isPositive = true}) {
    return Hero(
        tag: '${controller.topicId}${controller.heroTagAddition.value}',
        child: Material(
            child: ContentCard(
          isPositive ? 0 : controller.contentNegativeList.length-1,
          isPositive: isPositive,
        ))).width(324.w);
  }

  Widget loadingAnimationWidiget() {
    return Container(
      alignment: Alignment.topCenter,
      child: Lottie.asset(
        'assets/lotties/load-topic.json',
        width: 160.w,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
