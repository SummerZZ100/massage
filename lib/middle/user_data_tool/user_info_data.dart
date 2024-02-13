
class UserInfoData {

  UserInfoData({
      this.kefu,
      this.userName,
      this.photo, 
      this.sex,
      this.age, 
      this.birthday,
      this.key,
      this.userSign,
      this.phone,
      this.fans,
      this.cares
  });

  UserInfoData.fromJson(dynamic json) {
    kefu = json['kefu'];
    userName = json['user_name'];
    photo = json['photo'] != null ? json['photo'].cast<int>() : [];
    sex = json['sex'];
    age = json['age'];
    birthday = json['birthday'];
    key = json['key'];
    userSign = json['userSign'];
    phone = json['phone'];
    fans = json['fans'];
    cares = json['cares'];
  }

  String? key;//登录后请求公参
  String? kefu;//客服
  // int? tab;//0:显示首页,1:显示动态列表

  String? userName;
  String? userSign;
  List<int>? photo;
  String? sex;//1男 2女
  String? age;
  String? birthday;
  String? phone;
  int? fans;
  int? cares;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kefu'] = kefu;
    map['user_name'] = userName;
    map['photo'] = photo;
    map['sex'] = sex;
    map['age'] = age;
    map['birthday'] = birthday;
    map['key'] = key;
    map['userSign'] = userSign;
    map['phone'] = phone;
    map['fans'] = fans;
    map['cares'] = cares;

    return map;
  }

}