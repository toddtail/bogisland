class VersionCheck {
  int? versionCode;
  String? versionName;
  String? versionContent;
  String? versionTime;
  String? versionUrl;

  VersionCheck(
      {this.versionCode,
      this.versionName,
      this.versionContent,
      this.versionTime,
      this.versionUrl});

  VersionCheck.fromJson(Map<String, dynamic> json) {
    versionCode = json['versionCode'];
    versionName = json['versionName'];
    versionContent = json['versionContent'];
    versionTime = json['versionTime'];
    versionUrl = json['versionUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['versionCode'] = versionCode;
    data['versionName'] = versionName;
    data['versionContent'] = versionContent;
    data['versionTime'] = versionTime;
    data['versionUrl'] = versionUrl;
    return data;
  }
}
