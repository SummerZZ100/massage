
class ShanyanLoginRequest {

  ShanyanLoginRequest({
      this.signature, 
      this.result,});

  ShanyanLoginRequest.fromJson(dynamic json) {
    signature = json['signature'];
    result = json['result'];
  }

  String? signature;
  String? result;

ShanyanLoginRequest copyWith({  String? signature,
  String? result,
}) => ShanyanLoginRequest(  signature: signature ?? this.signature,
  result: result ?? this.result,
);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['signature'] = signature;
    map['result'] = result;
    return map;
  }

}