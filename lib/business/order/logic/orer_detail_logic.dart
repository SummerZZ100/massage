
import 'package:get/get.dart';
import 'package:massage/business/order/model/request_tool_order.dart';

import '../model/order_model.dart';

///  describtion

class OrderDetailLogic extends GetxController {

  OrderModel orderModel;
  bool netLoading = false;

   final dataNotifyId = 'dataNotifyId';
   final loadingNotifyId = 'loadingNotifyId';

  OrderDetailLogic({required this.orderModel});


  cancelOrder() async {
    netLoading = true;
    update([loadingNotifyId]);
    await RequestToolOrder.instance.cancelOrder(orderId: orderModel.orderNumber ?? 0);
    orderModel.orderStatus = '4';

    netLoading = false;
    update([loadingNotifyId,dataNotifyId]);
  }

  deleteOrder() async {
    netLoading = true;
    update([loadingNotifyId]);
    await RequestToolOrder.instance.deleteOrder(orderId: orderModel.orderNumber ?? 0);
    netLoading = false;
    update([loadingNotifyId,dataNotifyId]);
  }

}