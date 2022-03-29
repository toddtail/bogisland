import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';

class ContentArgumentModel {
  TopicInfo? topicData;
  String? heroType;  //mark or forum

  ContentArgumentModel({this.topicData, this.heroType = 'forum'}) {}

  ContentArgumentModel.fromJson(Map<String, dynamic> json) {
    topicData = json['topicData'];
    heroType = json['heroType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicData'] = topicData;
    data['heroType'] = heroType;
    return data;
  }
}
