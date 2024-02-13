
class RootPRequest {
  RootPRequest({
      this.veruaof,
      this.hlaefm,
      this.devahe,
      this.adni,
      this.devahe_mokef,
      this.mdad,
      this.lfg,
      this.lim,
      this.appname,});


  RootPRequest.fromJson(dynamic json) {
    veruaof = json['veruaof'];
    hlaefm = json['hlaefm'];
    devahe = json['devahe'];
    adni = json['adni'];
    devahe_mokef = json['devahe_mokef'];
    mdad = json['mdad'];
    lfg = json['lfg'];
    lim = json['lim'];
    appname = json['appname'];
  }


  String? veruaof;//版本号(veruaof)	格式：1.0.0(大版本.小版本.开发版本 )

  String? hlaefm;//客户端(client)	只能填写如下任意品牌iPhone: 苹果iPhone手机客户端 iPad: 苹果iPad客户端iPod: 苹果iPod客户端android: 谷歌安卓手机、平板客户端windowsPhone: 微软WindowsPhone客户端pc: pc个人电脑（windows系列）macBook: 苹果个人电脑（Mac电脑）web: 互联网产品

  String? devahe;//设备型号(device)	iPhone13,2

  String? adni;//广告标识(idfa)	请参阅苹果 AppleDoc。修改建议 如下:1、Info.plist 增加 NSUserTrackingUsageDescription 字段和自己的文案描述2、追踪框权限放在了 didbecameActive 里面、避免弹窗权限申请被覆盖3、弹窗文案示例：访问广告标识，推荐优质信息。

  String? devahe_mokef;//APNs设备码(device_token)	64位长度的一个码：f00b89377314eb8abdd88802cdaa93db72812025d7bfb49ec3e4ba61829f7f7f，如果用户未授权，请传空。查看规范

  String? mdad;//TakingData 唯一ID(tdid)	h10111c5633367e4f3c008630d5370f9a 查看规范

  String? lfg;//经度(lng)	116.123，如果用户未授权位置，请传0.0

  String? lim;//纬度(lat)	33.123，如果用户未授权位置，请传0.0

  String? appname;//应用名	应用名(英文)

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['veruaof'] = veruaof;
    map['hlaefm'] = hlaefm;
    map['devahe'] = devahe;
    map['adni'] = adni;
    map['devahe_mokef'] = devahe_mokef;
    map['mdad'] = mdad;
    map['lfg'] = lfg;
    map['lim'] = lim;
    map['appname'] = appname;
    return map;
  }

  printStr(){
    print("------ root_p_request");
  }

}