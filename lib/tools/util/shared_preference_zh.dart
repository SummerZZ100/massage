/**
 *    共享配置信息
 */
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceZH {
  static final SharedPreferenceZH _instance = SharedPreferenceZH();
  static SharedPreferenceZH get instance => _instance;

  /*
  * 获取是否隐藏隐私政策
  *
  * */
  Future<bool> obtainOffstagePrivacyPolicy() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool offstage = preferences.getBool('OffstagePP') ?? false;
    return offstage;
  }

  /*
  * 保存是否隐藏隐私政策数据
  * offstage : 是否隐藏隐私政策
  * */
  saveOffstagePrivacyPolicy({bool? offstage}) async {
    offstage ??= true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('OffstagePP', offstage);
  }

  /*
  * 获取app启动次数
  * */
  Future<int> obtainAppStartNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int number = preferences.getInt("AppStartNumber") ?? 0;
    return number;
  }

  /*
  * 保存app启动次数
  * */
  saveAppStartNumber() async{
    int number = await obtainAppStartNumber();
    number += 1;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("AppStartNumber", number);
  }

  /*
  * 获取是否已经询问过定位权限
  * */
  Future<bool> obtainHasLocationPermission() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool has = preferences.getBool('hasLocationP') ?? false;
    return has;
  }

  /*
  * 保存是否已经询问过定位权限
  * */
  saveHasLocationPermission() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('hasLocationP', true);
  }
  /*
  * 保存是否已经询问过AppTracking权限
  * */
  saveHasAppTrackingPermission() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('hasTrackingP', true);
  }

  /*
  * 获取是否已经询问过AppTracking权限权限
  * */
  Future<bool> obtainHasAppTrackingPermission() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool has = preferences.getBool('hasTrackingP') ?? false;
    return has;
  }

}

