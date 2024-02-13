import 'package:flutter/cupertino.dart';

/**
 *  describtion
 */


class CommonUtilZH {

  //工厂模式
  static CommonUtilZH? _instance;
  static CommonUtilZH? get instance => _getInstance();
  factory CommonUtilZH() => _getInstance()!;

  static CommonUtilZH? _getInstance() {
    _instance ??= CommonUtilZH._privateConstructor();
    return _instance;
  }

  CommonUtilZH._privateConstructor();

  /*
  * 底部空格
  * */
  bottomSpacing(BuildContext context,double space,{double? mHeight}){
    if(MediaQuery.of(context).padding.bottom > 0){
      return MediaQuery.of(context).padding.bottom;
    }
    return space;
  }

  /*
  * 根据生日计算年龄
  * */
  int birthdayToAge({required String birthday}){
    DateTime nowDate = DateTime.now();
    DateTime birthdayDate = DateTime.parse(birthday);
    int age = nowDate.year - birthdayDate.year;
    //再考虑月、天的因素
    if (nowDate.month < birthdayDate.month ||
        (nowDate.month == birthdayDate.month && nowDate.day < birthdayDate.day)) {
      age--;
    }
    age = age < 0 ? 0 : age;

    return age;

  }

}

