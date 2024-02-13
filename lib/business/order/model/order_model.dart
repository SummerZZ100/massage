import 'package:massage/business/home/models/Projects.dart';

import '../../home/models/ServiceUsers.dart';

class OrderModel {
  OrderModel({
      this.project, 
      this.serviceUser, 
      this.serviceItem, 
      this.number, 
      this.orderNumber, 
      this.address, 
      this.detailAddress, 
      this.contactName, 
      this.contactPhone, 
      this.sex, 
      this.serviceTime,
      this.orderStatus,
      this.createTime,
      this.payType,
      this.payId
  });

  OrderModel.fromJson(dynamic json) {
    project = json['project'] != null ? Projects.fromJson(json['project']) : null;
    serviceUser = json['serviceUser'] != null ? ServiceUsers.fromJson(json['serviceUser']) : null;
    serviceItem = json['serviceItem'];
    number = json['number'];
    orderNumber = json['orderNumber'];
    address = json['address'];
    detailAddress = json['detailAddress'];
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    sex = json['sex'];
    serviceTime = json['serviceTime'];
    orderStatus = json['orderStatus'];
    createTime = json['createTime'];
    payType = json['payType'];
    payId = json['payId'];

  }
  Projects? project;
  ServiceUsers? serviceUser;
  num? serviceItem;
  num? number;
  num? orderNumber;
  String? address;
  String? detailAddress;
  String? contactName;
  String? contactPhone;
  String? sex;
  String? serviceTime;
  String? orderStatus;//订单状态  1: 待接单   2: 待服务    3:已完成    4:已取消   5:已退款
  String? createTime;
  String? payType;//支付方式
  String? payId;//交易编号

OrderModel copyWith({  Projects? project,
  ServiceUsers? serviceUser,
  num? serviceItem,
  num? number,
  num? orderNumber,
  String? address,
  String? detailAddress,
  String? contactName,
  String? contactPhone,
  String? sex,
  String? serviceTime,
  String? orderStatus,
  String? createTime,
  String? payType,
  String? payId,
}) => OrderModel(  project: project ?? this.project,
  serviceUser: serviceUser ?? this.serviceUser,
  serviceItem: serviceItem ?? this.serviceItem,
  number: number ?? this.number,
  orderNumber: orderNumber ?? this.orderNumber,
  address: address ?? this.address,
  detailAddress: detailAddress ?? this.detailAddress,
  contactName: contactName ?? this.contactName,
  contactPhone: contactPhone ?? this.contactPhone,
  sex: sex ?? this.sex,
  serviceTime: serviceTime ?? this.serviceTime,
  orderStatus: orderStatus ?? this.orderStatus,
  createTime: createTime ?? this.createTime,
  payType: payType ?? this.payType,
  payId: payId ?? this.payId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (project != null) {
      map['project'] = project?.toJson();
    }
    if (serviceUser != null) {
      map['serviceUser'] = serviceUser?.toJson();
    }
    map['serviceItem'] = serviceItem;
    map['number'] = number;
    map['orderNumber'] = orderNumber;
    map['address'] = address;
    map['detailAddress'] = detailAddress;
    map['contactName'] = contactName;
    map['contactPhone'] = contactPhone;
    map['sex'] = sex;
    map['serviceTime'] = serviceTime;
    map['orderStatus'] = orderStatus;
    map['createTime'] = createTime;
    map['payId'] = payId;
    map['payType'] = payType;

    return map;
  }

}
