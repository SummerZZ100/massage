
import 'order_model.dart';

class OrderListM {
  OrderListM({
      this.orderList,});

  OrderListM.fromJson(dynamic json) {
    if (json['orderList'] != null) {
      orderList = [];
      json['orderList'].forEach((v) {
        orderList?.add(OrderModel.fromJson(v));
      });
    }
  }
  List<OrderModel>? orderList;
  OrderListM copyWith({  List<OrderModel>? orderList,
}) => OrderListM(  orderList: orderList ?? this.orderList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (orderList != null) {
      map['orderList'] = orderList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}