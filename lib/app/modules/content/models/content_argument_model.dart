import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';

class ContentArgumentModel {
  TopicInfo? topicData;

  ContentArgumentModel({this.topicData}) {}

  ContentArgumentModel.fromJson(Map<String, dynamic> json) {
    topicData = json['topicData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicData'] = topicData;
    return data;
  }
}
