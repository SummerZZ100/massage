import '../../order/model/order_model.dart';

class CommentModel {
  CommentModel({
      this.orderModel,
      this.comment,});

  CommentModel.fromJson(dynamic json) {
    orderModel = json['orderModel'] != null ? OrderModel.fromJson(json['orderModel']) : null;
    comment = json['comment'];
  }
  OrderModel? orderModel;
  String? comment;
CommentModel copyWith({OrderModel? orderModel,
  String? comment,
}) => CommentModel(  orderModel: orderModel ?? this.orderModel,
  comment: comment ?? this.comment,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (orderModel != null) {
      map['orderModel'] = orderModel?.toJson();
    }
    map['comment'] = comment;
    return map;
  }

}