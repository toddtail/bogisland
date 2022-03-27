import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';

ThreadsReply transferTopicInfoToThreadsReply(TopicInfo topicInfo) {
  Map<String, dynamic> data = {
    "id": topicInfo.id,
    "res": topicInfo.res,
    "time": topicInfo.time,
    "name": topicInfo.name,
    "cookie": topicInfo.cookie,
    "admin": topicInfo.admin,
    "content": topicInfo.content,
    "images": topicInfo.images
  };
  // if (topicInfo.images != null) {
  //   data['images'] = topicInfo.images!;
  // }
  return ThreadsReply.fromJson(data, isFromTopicInfo: true);
}
