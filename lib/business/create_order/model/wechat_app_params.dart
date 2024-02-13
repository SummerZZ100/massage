

class WechatAppParams {

  WechatAppParams({
      this.appId, 
      this.nonceStr, 
      this.packageStr, 
      this.partnerId, 
      this.paySign, 
      this.prepayId, 
      this.timeStamp,});

  WechatAppParams.fromJson(dynamic json) {
    appId = json['appId'];
    nonceStr = json['nonceStr'];
    packageStr = json['packageStr'];
    partnerId = json['partnerId'];
    paySign = json['paySign'];
    prepayId = json['prepayId'];
    timeStamp = json['timeStamp'];
  }

  String? appId;
  String? nonceStr;
  String? packageStr;
  String? partnerId;
  String? paySign;
  String? prepayId;
  String? timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appId'] = appId;
    map['nonceStr'] = nonceStr;
    map['packageStr'] = packageStr;
    map['partnerId'] = partnerId;
    map['paySign'] = paySign;
    map['prepayId'] = prepayId;
    map['timeStamp'] = timeStamp;
    return map;
  }

}