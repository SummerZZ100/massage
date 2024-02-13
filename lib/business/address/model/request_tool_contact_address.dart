import 'dart:convert';

import 'package:massage/business/address/model/Contact_address_list.dart';
import 'package:massage/business/address/model/Contact_address_model.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';

///  create by zhangxiaosong on 2023/9/12
///  describtion 

class RequestToolContactAddress {

  static final RequestToolContactAddress _instance = RequestToolContactAddress();
  static RequestToolContactAddress get instance => _instance;

  /*
  * 获取地址列表
  * */
  Future<List<ContactAddressModel>> getContactAddressList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonStr = preferences.getString('${UserDataLocalTool.instance.obtainKey()}_contact_address');
    List<ContactAddressModel> list = [];
    if((jsonStr?.length ?? 0) > 0){
      ContactAddressList contactAddressList = ContactAddressList.fromJson(jsonDecode(jsonStr!));
      list.addAll(contactAddressList.addressList ?? []);
    }
    return list;
  }

  clearContactAddressList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_contact_address',"");
  }

  /*
  * 保存地址列表
  * */
  saveContactAddressList({required ContactAddressList addressList}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_contact_address',
     jsonEncode(addressList.toJson()));
  }

  /*
  * 删除某条 地址信息
  * */
  Future<List<ContactAddressModel>> deleteContactAddress({required int item}) async {
    List<ContactAddressModel> list = await getContactAddressList();
    if(list.length > item){
      list.removeAt(item);
      await saveContactAddressList(addressList: ContactAddressList(addressList: list));
    }
    return list;
  }

  /*
  * 删除某条 地址信息
  * */
  Future<List<ContactAddressModel>> addContactAddress({required ContactAddressModel model}) async {
    List<ContactAddressModel> list = await getContactAddressList();
    list.insert(0, model);
    if(model.isDefault == true){
      for(int i = 0;i < list.length;i++){
        if(i == 0){
          continue;
        }
        ContactAddressModel ca = list[i];
        ca.isDefault = false;
      }
    }
    await saveContactAddressList(addressList: ContactAddressList(addressList: list));
    return list;
  }

  Future<List<ContactAddressModel>> modifyContactAddress({required ContactAddressModel model,required int item}) async {
    List<ContactAddressModel> list = await getContactAddressList();
    if(list.length > item){
      list.replaceRange(item, item+1, [model]);
      if(model.isDefault == true){
        for(int i = 0;i < list.length;i++){
          if(i == item){
            continue;
          }
          ContactAddressModel ca = list[i];
          ca.isDefault = false;
        }
      }
      await saveContactAddressList(addressList: ContactAddressList(addressList: list));
    }
    return list;
  }



}