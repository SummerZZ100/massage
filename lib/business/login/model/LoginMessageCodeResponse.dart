import 'dart:convert';

import 'LoginMessageCodeResponseData.dart';

/// code : 400
/// msg : "时钟校验失败，请用PRC时区"
/// data : {"clock":"22"}

LoginMessageCodeResponse loginMessageCodeResponseFromJson(String str) => LoginMessageCodeResponse.fromJson(json.decode(str));
String loginMessageCodeResponseToJson(LoginMessageCodeResponse data) => json.encode(data.toJson());
class LoginMessageCodeResponse {
  LoginMessageCodeResponse({
      num? code, 
      String? msg,
    LoginMessageCodeResponseData? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  LoginMessageCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? LoginMessageCodeResponseData.fromJson(json['data']) : null;
  }
  num? _code;
  String? _msg;
  LoginMessageCodeResponseData? _data;
LoginMessageCodeResponse copyWith({  num? code,
  String? msg,
  LoginMessageCodeResponseData? data,
}) => LoginMessageCodeResponse(  code: code ?? _code,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get code => _code;
  String? get msg => _msg;
  LoginMessageCodeResponseData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}