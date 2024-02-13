

import 'WechatData.dart';

class CreateOrderWechatResponse {
  CreateOrderWechatResponse({
      this.code, 
      this.msg, 
      this.data,});

  CreateOrderWechatResponse.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? WechatData.fromJson(json['data']) : null;
  }
  num? code;
  String? msg;
  WechatData? data;
  CreateOrderWechatResponse copyWith({  num? code,
  String? msg,
  WechatData? data,
}) => CreateOrderWechatResponse(  code: code ?? this.code,
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