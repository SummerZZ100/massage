import 'dart:convert';

/// type : "骞冲彴鍒�"
/// id : 8991
/// title : "骞冲彴閫氱敤浼樻儬鍒�"
/// desc : "璁㈠崟婊�100鍙娇鐢�"
/// note : "骞冲彴閫氱敤"
/// money : 10

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));

String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  Coupon({
      String? type, 
      num? id, 
      String? title, 
      String? desc, 
      String? note, 
      num? money,
      bool? had
  }){
    _type = type;
    _id = id;
    _title = title;
    _desc = desc;
    _note = note;
    _money = money;
    had = had;
}

  Coupon.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['id'];
    _title = json['title'];
    _desc = json['desc'];
    _note = json['note'];
    _money = json['money'];
    had = json['had'];
  }

  String? _type;
  num? _id;
  String? _title;
  String? _desc;
  String? _note;
  num? _money;
  bool? had;//是否领取

Coupon copyWith({  String? type,
  num? id,
  String? title,
  String? desc,
  String? note,
  num? money,
  bool? had,
}) => Coupon(  type: type ?? _type,
  id: id ?? _id,
  title: title ?? _title,
  desc: desc ?? _desc,
  note: note ?? _note,
  money: money ?? _money,
  had: had ?? had
);
  String? get type => _type;
  num? get id => _id;
  String? get title => _title;
  String? get desc => _desc;
  String? get note => _note;
  num? get money => _money;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['id'] = _id;
    map['title'] = _title;
    map['desc'] = _desc;
    map['note'] = _note;
    map['money'] = _money;
    map['had'] = had;
    return map;
  }

}