import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/order/model/order_model.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../middle/color_value.dart';

///  create by zhangxiaosong on 2023/9/14
///  describtion 

/*
* cId 1:取消  2:评价  3:删除
* */
typedef OrderControlWidgetBlock = Function(int cId);

class OrderControlWidget extends StatelessWidget {

  OrderModel orderModel;
  OrderControlWidgetBlock block;
  OrderControlWidget({super.key,required this.orderModel,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _subWidgets(),
      ),
    );
  }

  List<Widget> _subWidgets(){

    List<Widget> list = [];
// 1: 待接单   2: 待服务    3:已完成    4:已取消   5:已退款
    if(orderModel.orderStatus == '1'){
      list.add(
        TapContainer(childWidget: _btnWidget('取消订单'),
        clickBlock: (){
          block(1);
        },)
      );
    }
    else if(orderModel.orderStatus == '3'){
      list.add(
          TapContainer(childWidget: _btnWidget('去评价'),
            clickBlock: (){
              block(2);
            },)
      );
      list.add(SizedBox(width: 15.r,));
      list.add(
          TapContainer(childWidget: _btnWidget('删除订单'),
            clickBlock: (){
              block(3);
            },)
      );
    }
    else if(orderModel.orderStatus == '4' || orderModel.orderStatus == '5'){
      list.add(
          TapContainer(childWidget: _btnWidget('删除订单'),
            clickBlock: (){
              block(3);
            },)
      );
    }

    return list;

  }

  _btnWidget(String title){

    return Container(
      width: 70.r,
      height: 24.r,
      decoration: BoxDecoration(
        border: Border.all(color: ColorValue.blueColor(),width: 1),
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: ColorValue.blueColor(),
          decoration: TextDecoration.none,
        ),
        maxLines: 1,
      ),
    );

  }

}
