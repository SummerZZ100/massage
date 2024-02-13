import 'dart:convert';

/// clock : "22"

LoginMessageCodeResponseData dataFromJson(String str) => LoginMessageCodeResponseData.fromJson(json.decode(str));
String dataToJson(LoginMessageCodeResponseData data) => json.encode(data.toJson());
class LoginMessageCodeResponseData {
  LoginMessageCodeResponseData({
      String? clock,}){
    _clock = clock;
}

  LoginMessageCodeResponseData.fromJson(dynamic json) {
    _clock = json['clock'];
  }
  String? _clock;
  LoginMessageCodeResponseData copyWith({  String? clock,
}) => LoginMessageCodeResponseData(  clock: clock ?? _clock,
);
  String? get clock => _clock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clock'] = _clock;
    return map;
  }

}