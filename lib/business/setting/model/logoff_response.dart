
class LogOffResponse {

  LogOffResponse({
      this.code, 
      this.msg,});

  LogOffResponse.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
  }
  num? code;
  String? msg;
  LogOffResponse copyWith({  num? code,
  String? msg,
}) => LogOffResponse(  code: code ?? this.code,
  msg: msg ?? this.msg,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    return map;
  }

}