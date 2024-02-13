import 'dart:convert';
import '../../../middle/user_data_tool/user_info_data.dart';

/// code : 200
/// msg : "操作成功"
/// data : {"key":"1540245153119214245333231","kefu":"amshfapp@yeah.net","tab":0}

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      num? code, 
      String? msg,
    UserInfoData? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? UserInfoData.fromJson(json['data']) : null;
  }
  num? _code;
  String? _msg;
  UserInfoData? _data;
LoginResponse copyWith({  num? code,
  String? msg,
  UserInfoData? data,
}) => LoginResponse(  code: code ?? _code,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get code => _code;
  String? get msg => _msg;
  UserInfoData? get data => _data;

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