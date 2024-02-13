import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../model/order_model.dart';

///  create by zhangxiaosong on 2023/9/14
///  describtion 

class OrderAddressWidget extends StatelessWidget {

  OrderModel orderModel;
  OrderAddressWidget({super.key,required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "${SystemConfig.resource}order_location.png"
              ),
              SizedBox(width: 10.r,),
              Expanded(child: Text(
                '收货人：${orderModel.contactName}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
              )),
              Text(
                '${orderModel.contactPhone}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
              )
            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            children: [
              SizedBox(width: 26.r,),
              Expanded(child: Text(
                '${orderModel.address} ${orderModel.detailAddress}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 3,
              )),
            ],
          )
        ],
      ),
    );
  }
}
