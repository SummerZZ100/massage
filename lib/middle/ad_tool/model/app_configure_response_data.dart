
import 'advert_box.dart';

class AppConfigureResponseData {

  AppConfigureResponseData({
      this.mtime, 
      this.version, 
      this.full, 
      this.tab, 
      this.rank, 
      this.box, 
      this.kefu,
      this.prelogin,
      this.chat_unread,
      this.chat_url,
      this.my_need_url,
      this.my_account,
      this.onlinekefu,
      this.lgo,
  });

  AppConfigureResponseData.fromJson(dynamic json) {
    mtime = json['mtime'];
    version = json['version'];
    full = json['full'];
    tab = json['tab'];
    rank = json['rank'];
    box = json['box'] != null ? AdvertBox.fromJson(json['box']) : null;
    kefu = json['kefu'];
    prelogin = json['prelogin'];
    chat_unread = json['chat_unread'];
    chat_url = json['chat_url'];
    my_need_url = json['my_need_url'];
    my_account = json['my_account'];
    onlinekefu = json['onlinekefu'];
    lgo = json['lgo'];
  }

  String? mtime;
  String? version;
  String? full;
  String? tab;
  String? rank;
  AdvertBox? box;
  String? kefu;
  String? prelogin;//prelogin=0  或者没有这个参数，就默认先进到app  prelogin=1  启动判断出来后，就先跳转到登录
  String? chat_unread;
  String? chat_url;
  String? my_need_url;
  String? my_account;
  String? onlinekefu;
  String? lgo;// “0”要求不登录  “1” 要求登录

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mtime'] = mtime;
    map['version'] = version;
    map['full'] = full;
    map['tab'] = tab;
    map['rank'] = rank;
    if (box != null) {
      map['box'] = box!.toJson();
    }
    map['kefu'] = kefu;
    map['prelogin'] = prelogin;
    map['chat_unread'] = chat_unread;
    map['chat_url'] = chat_url;
    map['my_need_url'] = my_need_url;
    map['my_account'] = my_account;
    map['onlinekefu'] = onlinekefu;
    map['lgo'] = lgo;

    return map;

  }

}