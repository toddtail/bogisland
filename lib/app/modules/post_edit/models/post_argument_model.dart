class PostArgumentModel {
  bool? isNewPost;
  int? topicId;
  int? forumId;
  int? quoteId;

  PostArgumentModel(
      {this.isNewPost = true,
      this.topicId = 0,
      this.forumId = 1,
      this.quoteId}) {
    if (forumId == 0) {
      forumId = 1;
    }
  }

  PostArgumentModel.fromJson(Map<String, dynamic> json) {
    isNewPost = json['isNewPost'];
    topicId = json['topicId'];
    forumId = json['forumId'] == 0 ? 1 : json['forumId'];
    quoteId = json['quoteId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isNewPost'] = isNewPost;
    data['topicId'] = topicId;
    data['forumId'] = forumId;
    data['quoteId'] = quoteId;
    return data;
  }
}
