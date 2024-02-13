import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../model/order_model.dart';

///  create by zhangxiaosong on 2023/9/14
///  describtion 

class OrderPayWidget extends StatelessWidget {

  OrderModel orderModel;
  OrderPayWidget({super.key,required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          Text(
            _priceTitle(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          ),
          Expanded(child: Text(
            '¥${(orderModel.project?.price ?? 0) * (orderModel.number ?? 1)}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFFD9031D),
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
          )),
        ],
      ),
    );
  }

  _priceTitle(){
    String title = '';
    // 1: 待接单   2: 待服务    3:已完成    4:已取消   5:已退款
    if(orderModel.orderStatus == '1' || orderModel.orderStatus == '2'){
      title = '应付金额';
    }
    else if(orderModel.orderStatus == '3'){
      title = '实付金额';
    }
    else{
      title = '订单金额';
    }
    return title;
  }

}
