import 'WechatSign.dart';

class WechatData {
  WechatData({
      this.sign, 
      this.orderSn, 
      this.type, 
      this.id,});

  WechatData.fromJson(dynamic json) {
    sign = json['sign'] != null ? WechatSign.fromJson(json['sign']) : null;
    orderSn = json['order_sn'];
    type = json['type'];
    id = json['id'];
  }
  WechatSign? sign;
  String? orderSn;
  String? type;
  String? id;
  WechatData copyWith({  WechatSign? sign,
  String? orderSn,
  String? type,
  String? id,
}) => WechatData(  sign: sign ?? this.sign,
  orderSn: orderSn ?? this.orderSn,
  type: type ?? this.type,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sign != null) {
      map['sign'] = sign?.toJson();
    }
    map['order_sn'] = orderSn;
    map['type'] = type;
    map['id'] = id;
    return map;
  }

}