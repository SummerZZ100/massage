import 'dart:convert';
import 'dart:io';
import 'package:massage/middle/my_key_tool.dart';
import 'package:massage/middle/user_data_tool/user_info_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../tools/util/common_util_zh.dart';

/**
 *  登录信息存储
 */

class UserDataLocalTool {

  static final UserDataLocalTool _instance = UserDataLocalTool();
  static UserDataLocalTool get instance => _instance;

  bool hasLogin = false;//是否处于登录状态
  UserInfoData? userInfo;

  /// 登录
  Future login({required UserInfoData data}) async{

    await saveUserKey(data.key ?? "");

    bool hasLoaded = await readUserInfoFromSanBox();
    if(hasLoaded){//已经存储过用户信息
      _instance.userInfo?.key = data.key;
      _instance.userInfo?.kefu = data.kefu;
      _instance.hasLogin = true;
      await saveUserInfoToSanBox();
    }
    else{
      bool savedDefault = await _getSavedDefault('${data.key ?? 0}_user_saved');
      if(savedDefault){
        await _savedDefaultAlready('${data.key ?? 0}_user_saved');
        bool myKey = await MyKeyTool.instance.isMyKey();
        if(myKey){
          data.age = '23';
          data.birthday = '';
          data.userName = '1号玩家';
          data.sex = '1';
          data.userSign = '人生就要去享受';
          data.phone = '';
          data.fans = 3;
          data.cares = 0;
          _instance.userInfo = data;
          _instance.hasLogin = true;
          await saveUserInfoToSanBox();
        }
        else{
          _instance.userInfo ??= UserInfoData();
          _instance.userInfo!.key = data.key;
          _instance.userInfo!.kefu = data.kefu;
          _instance.hasLogin = true;
          await saveUserInfoToSanBox();
        }
      }
      else{
        _instance.userInfo ??= UserInfoData();
        _instance.userInfo?.key = data.key;
        _instance.userInfo?.kefu = data.kefu;
        _instance.hasLogin = true;
        await saveUserInfoToSanBox();
      }
    }
  }

  ///退出登录
  Future<void> logout() async {
    await saveUserKey("");
    _instance.userInfo = null;
    _instance.hasLogin = false;
  }

  /// 注销用户信息
  Future<void> logoff() async {
    _instance.userInfo = null;
    _instance.hasLogin = false;
    await saveUserInfoToSanBox();
    await saveUserKey("");
  }


  ///将用户信息存储到documents
  saveUserInfoToSanBox() async {
    String userKey = await getUserKey();
    String filePath = await _getFilePath("${userKey}_mUserInfo");
    File file = File(filePath);
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync('');
    file.writeAsStringSync(jsonEncode(_instance.userInfo));
  }

  ///从沙盒中读取用户信息
  Future<bool> readUserInfoFromSanBox() async {

    String userKey =await getUserKey();
    if(userKey.isNotEmpty){
      String filePath = await _getFilePath("${userKey}_mUserInfo");
      File file = File(filePath);
      if (!file.existsSync()) {
        return false;
      }
      String infoContent = file.readAsStringSync();
      if (infoContent.isNotEmpty) {
        Map<String, dynamic>? infoMap = jsonDecode(infoContent);
        if(infoMap != null){
          UserInfoData infoDto = UserInfoData.fromJson(infoMap);
          _instance.userInfo = infoDto;
          _instance.hasLogin = true;
          return true;
        }
        else{
          return false;
        }
      } else {
        return false;
      }
    }
    return false;

  }

  /*
  * 更新用户信息
  * */
  Future refreshUserInfo({UserInfoData? model}) async {
    if(model != null){
      _instance.userInfo = model;
      _instance.hasLogin = true;
      await saveUserInfoToSanBox();
    }
  }
  /// 更新用户姓名
  Future<void> changeUserName(String name) async{
    _instance.userInfo!.userName = name;
    await saveUserInfoToSanBox();
  }

  /// 更新用户年龄
  Future<void> changeAge(String birthday) async{

    int age = CommonUtilZH.instance!.birthdayToAge(birthday: birthday);
    _instance.userInfo!.age = '$age';
    _instance.userInfo!.birthday = birthday;
    await saveUserInfoToSanBox();

  }

  /// 更新用户性别
  changeGender(String gender) async{
    _instance.userInfo!.sex = gender;
    await saveUserInfoToSanBox();

  }

  /// 更新用户头像
  changeHeader(List<int> bytes) async{

    _instance.userInfo!.photo = bytes;
    await saveUserInfoToSanBox();

  }

  /// 更新用户签名
  changeUserSign(String userSign) async{

    _instance.userInfo!.userSign = userSign;
    await saveUserInfoToSanBox();

  }

  /// 更新用户手机号
  changeUserPhone(String phone) async{

    _instance.userInfo!.phone = phone;
    await saveUserInfoToSanBox();

  }

  /*
  * 获取用户key H5拼接key
  * */
  obtainKey(){
    return (_instance.userInfo?.key ?? '');
  }

  obtainUserName(){
    return (_instance.userInfo?.userName ?? "");
  }

  List<int> obtainHeader(){
    return (_instance.userInfo?.photo ?? []);
  }

  obtainSignName(){
    return (_instance.userInfo?.userSign ?? "");
  }

  obtainSex(){
    if('2' == _instance.userInfo?.sex){
      return '女';
    }
    else if('1' == _instance.userInfo?.sex){
      return '男';
    }
    return '';
  }

  obtainAge(){
    return (_instance.userInfo?.age ?? "");
  }

  obtainPhone(){
    return (_instance.userInfo?.phone ?? "");
  }

  obtainFansNumber(){
    return (_instance.userInfo?.fans ?? 0);
  }

  obtainCareNumber(){
    return (_instance.userInfo?.cares ?? 0);
  }

  ///用户信息文件路径
  Future<String> _getFilePath(String fileName) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentsPath = documentDirectory.path;
    return '$documentsPath/$fileName';
  }

  Future<bool> _getSavedDefault(String key) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool canSave = preferences.getBool(key) ?? true;

    return canSave;

  }

  _savedDefaultAlready(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, false);
  }

  Future<String> getUserKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String key = preferences.getString("user_key_m") ?? "";
    return key;
  }

  saveUserKey(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("user_key_m", key);
  }


}