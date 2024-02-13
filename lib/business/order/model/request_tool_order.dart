import 'dart:convert';
import 'dart:math';
import 'package:massage/business/order/model/order_list_m.dart';
import 'package:massage/business/order/model/order_model.dart';
import 'package:massage/business/order/model/order_r.dart';
import 'package:massage/middle/my_key_tool.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';

///  create by zhangxiaosong on 2023/9/12
///  describtion 

class RequestToolOrder {

  static final RequestToolOrder _instance = RequestToolOrder();
  static RequestToolOrder get instance => _instance;

  /*
  * 用户默认订单
  * */
  Future<void> defaultUserOrderList() async {

    bool canSaveDefault = await getSavedDefault();
    if(canSaveDefault){

      await savedDefaultAlready();
      bool myKey = await MyKeyTool.instance.isMyKey();
      if(myKey){
        OrderListM listM = OrderListM.fromJson(jsonDecode(OrderR.orderJson));
        await saveOrderList(orderListM: listM);
      }
    }

  }

  Future<bool> getSavedDefault() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool canSave = preferences.getBool('${UserDataLocalTool.instance.obtainKey()}_order_saved') ?? true;

    return canSave;

  }

  savedDefaultAlready() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('${UserDataLocalTool.instance.obtainKey()}_order_saved', false);
  }

  /*
  * 获取订单列表
  * */
  Future<List<OrderModel>> getOrderList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonStr = preferences.getString('${UserDataLocalTool.instance.obtainKey()}_order');
    List<OrderModel> list = [];
    if((jsonStr?.length ?? 0) > 0){
      OrderListM orderListM = OrderListM.fromJson(jsonDecode(jsonStr!));
      list.addAll(orderListM.orderList ?? []);
    }
    return list;
  }

  clearOrderList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_order',"");
  }

  /*
  * 保存订单列表
  * */
  saveOrderList({required OrderListM orderListM}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_order',
     jsonEncode(orderListM.toJson()));
  }

  /*
  * 创建订单
  * */
  Future<List<OrderModel>> createOrder({required OrderModel model}) async {
    DateTime dateTime = DateTime.now();
    int lastNum = Random().nextInt(9);
    String orderNumber = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}$lastNum';
    model.orderNumber = num.parse(orderNumber);
    List<OrderModel> list = await getOrderList();
    list.insert(0, model);
    await saveOrderList(orderListM: OrderListM(orderList: list));
    return list;
  }

  /*
  * 删除订单
  * */
  deleteOrder({required num orderId}) async {

    List<OrderModel> list = await getOrderList();
    for(int i = 0;i < list.length;i++){
      OrderModel model = list[i];
      if(orderId == model.orderNumber){
        list.removeAt(i);
        break;
      }
    }

    await saveOrderList(orderListM: OrderListM(orderList: list));

  }

  cancelOrder({required num orderId}) async {
    List<OrderModel> list = await getOrderList();
    for(int i = 0;i < list.length;i++){
      OrderModel model = list[i];
      if(orderId == model.orderNumber){
        model.orderStatus = '4';
        break;
      }
    }

    await saveOrderList(orderListM: OrderListM(orderList: list));
  }

}