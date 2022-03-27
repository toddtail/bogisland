import 'package:bog_island/app/modules/content/models/threads_model.dart';

class ContentArgumentModel {
  ThreadsReply? topicData;

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
