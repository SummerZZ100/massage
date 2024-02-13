

import 'app_configure_response_data.dart';

class AppConfigureResponse {

  AppConfigureResponse({
      this.code, 
      this.message,
      this.configData,});

  AppConfigureResponse.fromJson(dynamic json) {
    code = json['code'];
    message = json['msg'];
    configData = json['data'] != null ? AppConfigureResponseData.fromJson(json['data']) : null;
  }

  int? code;
  String? message;
  AppConfigureResponseData? configData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = message;
    if (configData != null) {
      map['data'] = configData!.toJson();
    }
    return map;
  }

}