
import 'AlipayData.dart';

class CreateOrderAlipayResponse {
  CreateOrderAlipayResponse({
      this.code, 
      this.msg, 
      this.data,});

  CreateOrderAlipayResponse.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? AlipayData.fromJson(json['data']) : null;
  }
  num? code;
  String? msg;
  AlipayData? data;
CreateOrderAlipayResponse copyWith({  num? code,
  String? msg,
  AlipayData? data,
}) => CreateOrderAlipayResponse(  code: code ?? this.code,
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