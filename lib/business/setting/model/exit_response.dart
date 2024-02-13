
class ExitResponse {

  ExitResponse({
      this.code, 
      this.msg,
      this.data,});

  ExitResponse.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }
  num? code;
  String? msg;
  bool? data;
ExitResponse copyWith({  num? code,
  String? msg,
  bool? data,
}) => ExitResponse(  code: code ?? this.code,
  msg: msg ?? this.msg,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['data'] = data;
    return map;
  }

}