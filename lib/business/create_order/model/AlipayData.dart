
class AlipayData {
  AlipayData({
      this.sign, 
      this.orderSn, 
      this.type, 
      this.id,});

  AlipayData.fromJson(dynamic json) {
    sign = json['sign'];
    orderSn = json['order_sn'];
    type = json['type'];
    id = json['id'];
  }

  String? sign;
  String? orderSn;
  String? type;
  String? id;

  AlipayData copyWith({  String? sign,
  String? orderSn,
  String? type,
  String? id,
}) => AlipayData(  sign: sign ?? this.sign,
  orderSn: orderSn ?? this.orderSn,
  type: type ?? this.type,
  id: id ?? this.id,
);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sign'] = sign;
    map['order_sn'] = orderSn;
    map['type'] = type;
    map['id'] = id;
    return map;
  }

}