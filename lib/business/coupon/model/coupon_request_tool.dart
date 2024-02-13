import 'dart:convert';

import 'package:massage/business/coupon/model/coupon_id_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../middle/user_data_tool/user_data_local_tool.dart';

///  create by zhangxiaosong on 2023/9/16
///  describtion 

class CouponRequestTool {

  static final _instance = CouponRequestTool();
  static CouponRequestTool get instance => _instance;

  /*
  * 是否已经领取优惠券
  * */
  Future<bool> hasGetCurrentCoupon(num couponId) async {
    bool get = false;
    List<num> list = await getCouponList();
    if(list.isNotEmpty){
      for(int i = 0;i < list.length;i++){
        num cId = list[i];
        if(cId == couponId){
          get = true;
          break;
        }
      }
    }
    return get;
  }

  /*
  * 获取优惠券
  * */
  Future<List<num>> getCouponList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonStr = preferences.getString('${UserDataLocalTool.instance.obtainKey()}_coupon');
    List<num> list = [];
    if((jsonStr?.length ?? 0) > 0){
      CouponIdList couponIdList = CouponIdList.fromJson(jsonDecode(jsonStr!));
      list.addAll(couponIdList.couponIds ?? []);
    }
    return list;
  }

  clearCouponList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_coupon',"");
  }

  /*
  * 保存优惠券列表
  * */
  saveCouponList({required CouponIdList couponIdList}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_coupon',
        jsonEncode(couponIdList.toJson()));
  }

  /*
  * 添加优惠券
  * */
  Future<List<num>> addCoupon({required num couponId}) async {
    List<num> list = await getCouponList();
    list.insert(0, couponId);
    await saveCouponList(couponIdList: CouponIdList(couponIds: list));
    return list;
  }


}