class LogoffAlertResponse {
  LogoffAlertResponse({
      this.code, 
      this.msg, 
      this.data,});

  LogoffAlertResponse.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? LogoffResponseData.fromJson(json['data']) : null;
  }
  num? code;
  String? msg;
  LogoffResponseData? data;

LogoffAlertResponse copyWith({  num? code,
  String? msg,
  LogoffResponseData? data,
}) => LogoffAlertResponse(  code: code ?? this.code,
  msg: msg ?? this.msg,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class LogoffResponseData {
  LogoffResponseData({
      this.tip,});

  LogoffResponseData.fromJson(dynamic json) {
    tip = json['tip'];
  }
  String? tip;
  LogoffResponseData copyWith({  String? tip,
}) => LogoffResponseData(  tip: tip ?? this.tip,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tip'] = tip;
    return map;
  }

}