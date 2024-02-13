import 'dart:convert';

import 'package:massage/business/all_service_users/model/waiter_care.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../middle/user_data_tool/user_data_local_tool.dart';

///  create by zhangxiaosong on 2023/9/16
///  describtion 

class RequestWaiterTool {

  static final _instance = RequestWaiterTool();
  static RequestWaiterTool get instance => _instance;

  /*
  * 是否已经关注
  * */
  Future<bool> hasCared(num careId) async {
    bool get = false;
    List<num> list = await getCareList();
    if(list.isNotEmpty){
      for(int i = 0;i < list.length;i++){
        num cId = list[i];
        if(cId == careId){
          get = true;
          break;
        }
      }
    }
    return get;
  }

  /*
  * 获取关注列表
  * */
  Future<List<num>> getCareList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonStr = preferences.getString('${UserDataLocalTool.instance.obtainKey()}_care');
    List<num> list = [];
    if((jsonStr?.length ?? 0) > 0){
      WaiterCare careList = WaiterCare.fromJson(jsonDecode(jsonStr!));
      list.addAll(careList.careList ?? []);
    }
    return list;
  }

  clearCareList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_care',"");
  }

  /*
  * 保存关注列表
  * */
  saveCareList({required WaiterCare careIdList}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_care',
        jsonEncode(careIdList.toJson()));
  }

  /*
  * 添加关注
  * */
  Future<List<num>> addCare({required num careId}) async {
    List<num> list = await getCareList();
    list.insert(0, careId);
    await saveCareList(careIdList: WaiterCare(careList: list));
    return list;
  }

  /*
  * 是否已经加入黑名单
  * */
  Future<bool> hasBlacked(num blackId) async {
    bool get = false;
    List<num> list = await getBlackList();
    if(list.isNotEmpty){
      for(int i = 0;i < list.length;i++){
        num cId = list[i];
        if(cId == blackId){
          get = true;
          break;
        }
      }
    }
    return get;
  }

  /*
  * 获取黑名单列表
  * */
  Future<List<num>> getBlackList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonStr = preferences.getString('${UserDataLocalTool.instance.obtainKey()}_black');
    List<num> list = [];
    if((jsonStr?.length ?? 0) > 0){
      WaiterCare blackList = WaiterCare.fromJson(jsonDecode(jsonStr!));
      list.addAll(blackList.careList ?? []);
    }
    return list;
  }

  clearBlackList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_black',"");
  }

  /*
  * 保存黑名单列表
  * */
  saveBlackList({required WaiterCare blackList}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_black',
        jsonEncode(blackList.toJson()));
  }

  /*
  * 加入黑名单
  * */
  Future<List<num>> addBlack({required num blackId}) async {
    List<num> list = await getBlackList();
    list.insert(0, blackId);
    await saveBlackList(blackList: WaiterCare(careList: list));
    return list;
  }

}