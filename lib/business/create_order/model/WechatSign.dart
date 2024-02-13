
class WechatSign {
  WechatSign({
      this.appid, 
      this.partnerid, 
      this.prepayid, 
      this.package, 
      this.noncestr, 
      this.timestamp, 
      this.link,
      this.signPay, 
      this.orderId,});

  WechatSign.fromJson(dynamic json) {
    appid = json['appid'];
    partnerid = json['partnerid'];
    prepayid = json['prepayid'];
    package = json['package'];
    noncestr = json['noncestr'];
    timestamp = json['timestamp'];
    link = json['link'];
    signPay = json['signPay'];
    orderId = json['orderId'];
  }
  String? appid;
  String? partnerid;
  String? prepayid;
  String? package;
  String? noncestr;
  String? timestamp;
  String? link;
  String? signPay;
  String? orderId;
  WechatSign copyWith({  String? appid,
  String? partnerid,
  String? prepayid,
  String? package,
  String? noncestr,
  String? timestamp,
  String? link,
  String? signPay,
  String? orderId,
}) => WechatSign(  appid: appid ?? this.appid,
  partnerid: partnerid ?? this.partnerid,
  prepayid: prepayid ?? this.prepayid,
  package: package ?? this.package,
  noncestr: noncestr ?? this.noncestr,
  timestamp: timestamp ?? this.timestamp,
  link: link ?? this.link,
  signPay: signPay ?? this.signPay,
  orderId: orderId ?? this.orderId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appid'] = appid;
    map['partnerid'] = partnerid;
    map['prepayid'] = prepayid;
    map['package'] = package;
    map['noncestr'] = noncestr;
    map['timestamp'] = timestamp;
    map['link'] = link;
    map['signPay'] = signPay;
    map['orderId'] = orderId;
    return map;
  }

}