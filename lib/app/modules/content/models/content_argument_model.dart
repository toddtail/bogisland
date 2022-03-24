class ContentArgumentModel {
  int? topicId;
  int? topicIndexInForum;

  ContentArgumentModel({this.topicId = 0, this.topicIndexInForum = 0}) {}

  ContentArgumentModel.fromJson(Map<String, dynamic> json) {
    topicIndexInForum = json['topicIndexInForum'];
    topicId = json['topicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicIndexInForum'] = topicIndexInForum;
    data['topicId'] = topicId;
    return data;
  }
}
