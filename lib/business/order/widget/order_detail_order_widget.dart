import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/order_model.dart';


class OrderDetailOrderWidget extends StatelessWidget {

  OrderModel orderModel;
  OrderDetailOrderWidget({super.key,required this.orderModel});

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
        children: _subWidgets()
      ),
    );
  }

  List<Widget> _subWidgets(){
    List<Widget> list = [];

    list.add(Text(
      '订单信息',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: const Color(0xFF333333),
        decoration: TextDecoration.none,
      ),
      maxLines: 1,
    ));
    //订单编号
    list.add(Padding(padding: EdgeInsets.only(top: 8.r),
    child: Row(
      children: [
        Text(
          '订单编号:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: const Color(0xFF333333),
            decoration: TextDecoration.none,
          ),
          maxLines: 1,
        ),
        Expanded(child: Text(
          '${orderModel.orderNumber}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: const Color(0xFF999999),
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
        )),
      ],
    ),));
    //创建时间
    list.add(Padding(padding: EdgeInsets.only(top: 8.r),
      child: Row(
        children: [
          Text(
            '创建时间:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          ),
          Expanded(child: Text(
            '${orderModel.createTime}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF999999),
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
          )),
        ],
      ),));

    if(orderModel.orderStatus == '3' || orderModel.orderStatus == '5'){//支付方式
      list.add(Padding(padding: EdgeInsets.only(top: 8.r),
        child: Row(
          children: [
            Text(
              '支付方式:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF333333),
                decoration: TextDecoration.none,
              ),
              maxLines: 1,
            ),
            Expanded(child: Text(
              '${orderModel.payType}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF999999),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
            )),
          ],
        ),));
    }
    if(orderModel.orderStatus == '5'){
      list.add(Padding(padding: EdgeInsets.only(top: 8.r),
        child: Row(
          children: [
            Text(
              '退回方式:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF333333),
                decoration: TextDecoration.none,
              ),
              maxLines: 1,
            ),
            Expanded(child: Text(
              '原路退回至 ${orderModel.payType}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF999999),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
            )),
          ],
        ),));
    }
    if(orderModel.orderStatus == '3'){
      list.add(Padding(padding: EdgeInsets.only(top: 8.r),
        child: Row(
          children: [
            Text(
              '交易编号:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF333333),
                decoration: TextDecoration.none,
              ),
              maxLines: 1,
            ),
            Expanded(child: Text(
              '${orderModel.payId}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF999999),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
            )),
          ],
        ),));
    }

    return list;
  }

}
