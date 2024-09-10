class SetDeviceInfoRequest {
  String? deviceName;
  String? factoryName;
  int? osType;
  String? osVersion;
  String? appVersion;
  String? firebaseId;
  String? lang;
  String? deviceId;
  String? buildType;

  SetDeviceInfoRequest({
    this.deviceName,
    this.factoryName,
    this.osType,
    this.osVersion,
    this.appVersion,
    this.firebaseId,
    this.lang,
    this.deviceId,
    this.buildType,
  });

  SetDeviceInfoRequest.fromJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    factoryName = json['factoryName'];
    osType = json['osType'];
    osVersion = json['osVersion'];
    appVersion = json['appVersion'];
    firebaseId = json['firebaseId'];
    lang = json['lang'];
    deviceId = json['deviceId'];
    buildType = json['buildType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceName'] = deviceName;
    data['factoryName'] = factoryName;
    data['osType'] = osType;
    data['osVersion'] = osVersion;
    data['appVersion'] = appVersion;
    data['firebaseId'] = firebaseId;
    data['lang'] = lang;
    data['deviceId'] = deviceId;
    data['buildType'] = buildType;
    return data;
  }
}
