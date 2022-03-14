import 'package:bog_island/app/modules/forum/widgets/topic_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Obx(
        () => controller.forumTopicList.isEmpty
            ? Container()
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    controller.loadTopic();
                  }
                  return true;
                },
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return TopicCard(index);
                  },
                  itemCount: controller.forumTopicList.length,
                ),
              ),
      )),
    );
  }
}
