import 'dart:convert';
import 'dart:io';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:path_provider/path_provider.dart';

import 'InteractiveUsers.dart';
import 'Interactive_model.dart';


/**
 *  交互信息本地存储
 */

class  LocalInteractiveUtil{

  final XiangMiLocalData_Interactive = 'XiangMiLocalData_Interactive';

  static LocalInteractiveUtil? _instance;
  factory LocalInteractiveUtil() => _getInstance()!;
  static LocalInteractiveUtil? get instance => _getInstance();
  static LocalInteractiveUtil? _getInstance(){

    if(_instance == null){

      _instance = LocalInteractiveUtil._privateConstructor();
      return _instance;

    }
    return _instance;
  }

  LocalInteractiveUtil._privateConstructor();

  InteractiveModel? interactiveModel;


  ///从沙盒中读取交互信息
  Future<bool> readUserInteractiveFromSanBox() async {
    String filePath = await _getFilePath(XiangMiLocalData_Interactive);
    File file = File(filePath);
    if (!file.existsSync()) {
      return false;
    }
    String infoContent = file.readAsStringSync();
    if (infoContent.isNotEmpty) {
      Map<String, dynamic>? infoMap = jsonDecode(infoContent);
      if(infoMap != null){
        InteractiveModel interactiveModel = InteractiveModel.fromJson(infoMap);
        _instance!.interactiveModel = interactiveModel;
        return true;
      }
      else{
        return false;
      }
    } else {
      return false;
    }
  }

  /*
  * 保存关注
  * */
  Future<void> saveCare({required num careUserId}) async {

    _instance!.interactiveModel ??= InteractiveModel();

    if((_instance!.interactiveModel!.interactiveUsers?.length ?? 0) > 0){//已经存在用户交互列表

      InteractiveUsers? modifyUser;
      for(int i = 0;i < _instance!.interactiveModel!.interactiveUsers!.length;i++){
        InteractiveUsers interactiveUsers = _instance!.interactiveModel!.interactiveUsers![i];
        if(interactiveUsers.key == UserDataLocalTool.instance!.userInfo?.key){
          modifyUser = interactiveUsers;
          break;
        }
      }

      if(modifyUser == null){//不存在当前用户交互信息
        modifyUser = InteractiveUsers();
        modifyUser.key = UserDataLocalTool.instance!.userInfo?.key;
        modifyUser.cares = [careUserId];
        _instance!.interactiveModel!.interactiveUsers!.add(modifyUser);
      }
      else{//存在当前用户交互信息
        modifyUser.cares ??= [];
        modifyUser.cares!.add(careUserId);
      }

    }
    else{//存储数据为空
      InteractiveUsers interactiveUsers = InteractiveUsers();
      interactiveUsers.key = UserDataLocalTool.instance!.userInfo?.key;
      interactiveUsers.cares = [careUserId];
      _instance!.interactiveModel!.interactiveUsers = [interactiveUsers];
    }

    await _saveUserInteractiveToSanBox();

  }

  /*
  * 保存黑名单
  * */
  Future<void> saveBlack({required num blackUserId}) async {

    _instance!.interactiveModel ??= InteractiveModel();

    if((_instance!.interactiveModel!.interactiveUsers?.length ?? 0) > 0){//已经存在用户交互列表

      InteractiveUsers? modifyUser;
      for(int i = 0;i < _instance!.interactiveModel!.interactiveUsers!.length;i++){
        InteractiveUsers interactiveUsers = _instance!.interactiveModel!.interactiveUsers![i];
        if(interactiveUsers.key == UserDataLocalTool.instance!.userInfo?.key){
          modifyUser = interactiveUsers;
          break;
        }
      }

      if(modifyUser == null){//不存在当前用户交互信息
        modifyUser = InteractiveUsers();
        modifyUser.key = UserDataLocalTool.instance!.userInfo?.key;
        modifyUser.blacks = [blackUserId];
        _instance!.interactiveModel!.interactiveUsers!.add(modifyUser);
      }
      else{//存在当前用户交互信息
        modifyUser.blacks ??= [];
        modifyUser.blacks!.add(blackUserId);
      }

    }
    else{//存储数据为空
      InteractiveUsers interactiveUsers = InteractiveUsers();
      interactiveUsers.key = UserDataLocalTool.instance!.userInfo?.key;
      interactiveUsers.blacks = [blackUserId];
      _instance!.interactiveModel!.interactiveUsers = [interactiveUsers];
    }

    await _saveUserInteractiveToSanBox();

  }

  /*
  * 是否已经关注
  * */
  Future<bool> inCare({required num userId}) async {

    bool inCare = false;
    if((_instance!.interactiveModel?.interactiveUsers?.length ?? 0) > 0){

      print('--- u == $userId   ${_instance!.interactiveModel!.toJson()}');

      InteractiveUsers? modifyUser;
      for(int i = 0;i < _instance!.interactiveModel!.interactiveUsers!.length;i++){
        InteractiveUsers interactiveUsers = _instance!.interactiveModel!.interactiveUsers![i];
        if(interactiveUsers.key == UserDataLocalTool.instance!.userInfo?.key){
          modifyUser = interactiveUsers;
          break;
        }
      }

      if(modifyUser != null){
        print('--- u == 1');
        if((modifyUser.cares?.length ?? 0) > 0){
          for(int j =0;j < modifyUser.cares!.length;j++){
            num careUserId = modifyUser.cares![j];
            if(careUserId == userId){
              inCare = true;
              break;
            }
          }
        }
      }

    }

    return inCare;

  }

  /*
  * 是否已经拉黑
  * */
  Future<bool> inBlack({required num userId}) async {

    bool inBlack = false;

    if((_instance!.interactiveModel?.interactiveUsers?.length ?? 0) > 0){

      InteractiveUsers? modifyUser;
      for(int i = 0;i < _instance!.interactiveModel!.interactiveUsers!.length;i++){
        InteractiveUsers interactiveUsers = _instance!.interactiveModel!.interactiveUsers![i];
        if(interactiveUsers.key == UserDataLocalTool.instance!.userInfo?.key){
          modifyUser = interactiveUsers;
          break;
        }
      }
      if(modifyUser != null){
        if((modifyUser.blacks?.length ?? 0) > 0){
          for(int j =0;j < modifyUser.blacks!.length;j++){
            num blackUserId = modifyUser.blacks![j];
            if(blackUserId == userId){
              inBlack = true;
              break;
            }
          }
        }
      }
    }

    return inBlack;

  }


  ///将交互信息存储到documents
  _saveUserInteractiveToSanBox() async {
    String filePath = await _getFilePath(XiangMiLocalData_Interactive);
    File file = File(filePath);
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync('');
    print("write == ${jsonEncode(_instance!.interactiveModel)}");
    file.writeAsStringSync(jsonEncode(_instance!.interactiveModel));
  }

  ///用户信息文件路径
  Future<String> _getFilePath(String fileName) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentsPath = documentDirectory.path;
    return '$documentsPath/$fileName';
  }


}