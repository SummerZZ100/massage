
import 'package:get/get.dart';
import 'package:massage/business/order/model/request_tool_order.dart';

import '../model/order_model.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class OrderListLogic extends GetxController {

   List<OrderModel> orderList = [];
   bool netLoading = true;

   final dataNotifyId = 'dataNotifyId';
   final loadingNotifyId = 'loadingNotifyId';

   requestOrderList(int index,bool notify) async {

     netLoading = true;
     orderList.clear();

     if(notify){
       update([loadingNotifyId,dataNotifyId]);
     }

     List<OrderModel> list = await RequestToolOrder.instance.getOrderList();

     if(index == 0){//全部
       orderList.addAll(list);
     }
     else if(index == 1){//待接单
       for(int i = 0;i < list.length;i++){
         OrderModel model = list[i];
         if(model.orderStatus == '1'){
           orderList.add(model);
         }
       }
     }
     else if(index == 3){//已完成
       for(int i = 0;i < list.length;i++){
         OrderModel model = list[i];
         if(model.orderStatus == '3'){
           orderList.add(model);
         }
       }
     }
     else if(index == 4){//退款
       for(int i = 0;i < list.length;i++){
         OrderModel model = list[i];
         if(model.orderStatus == '5'){
           orderList.add(model);
         }
       }
     }

     await Future.delayed(const Duration(milliseconds: 500));

     netLoading = false;
     update([dataNotifyId,loadingNotifyId]);

   }

   cancelOrder(int row,int currentIndex) async {
     OrderModel orderModel = orderList[row];
     update([loadingNotifyId]);
     await RequestToolOrder.instance.cancelOrder(orderId: orderModel.orderNumber ?? 0);
     requestOrderList(currentIndex, false);
   }

   deleteOrder(int row,int currentIndex) async {
     OrderModel orderModel = orderList[row];
     update([loadingNotifyId]);
     await RequestToolOrder.instance.deleteOrder(orderId: orderModel.orderNumber ?? 0);
     requestOrderList(currentIndex, false);
   }

}