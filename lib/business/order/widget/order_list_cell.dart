import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/order/widget/order_control_widget.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../model/order_model.dart';

///  create by zhangxiaosong on 2023/9/12
///  describtion 

/*
* cId 1:取消  2:评价  3:删除
* */
typedef OrderListCellBlock = Function(int cId);

class OrderListCell extends StatelessWidget {

  OrderModel model;
  OrderListCellBlock block;

  OrderListCell({super.key,required this.model,required this.block});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 15.r,right: 15.r,top: 10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.project?.name ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 10.r,),
          Row(
            children: [
              ImageWidgetZH(
                imageUrl: _imageUrl(),
                imageWidth: 64.r,
                imageHeight: 64.r,
                style: 1,
                fit:BoxFit.cover,
                radius: 4.r,
              ),
              SizedBox(width: 14.r,),
              Expanded(child:
              SizedBox(
                height: 64.r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(
                          _itemPStr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: const Color(0xFF333333),
                            decoration: TextDecoration.none,
                          ),
                        ),),
                        Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                  text: '${model.project?.price ?? 0}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFFD9031D),
                                  ),
                                ),
                                TextSpan(
                                  text: '元/次',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFFD9031D),
                                  ),
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(
                          model.serviceTime ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF999999),
                            decoration: TextDecoration.none,
                          ),
                        ),),
                        Text(
                          "x${model.number}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF999999),
                            decoration: TextDecoration.none,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 14.r,bottom: 14.r),
            child:const Divider(
              height: 1,
              color: Color(0xFFEAEAEA),
            ),),
          Row(
            children: [
              Expanded(child: Text(
                _statusDetail(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
              )),
              OrderControlWidget(orderModel: model, block: (int cId){
                 block(cId);
              }),
            ],
          ),
        ],
      ),
    );

  }

  _imageUrl(){
    String image = '';
    if((model.project?.imgSrc?.length ?? 0)  > 0){
      if(model.project!.imgSrc!.length > (model.serviceItem ?? 0)){
        int item = (model.serviceItem ?? 0).toInt();
        image = model.project!.imgSrc![item];
      }
      else{
        image = model.project!.imgSrc![0];
      }
    }

    return image;
  }

  _itemPStr(){
    String itemS = model.project?.name ?? '';
    int item = (model.serviceItem ?? 0).toInt();
    if((model.project?.services?.length ?? 0) > item){
      itemS = model.project!.services![item];
    }
    return itemS;
  }

  _statusDetail(){
    String detail = '';
    if(model.orderStatus == '1'){
      detail = '待接单';
    }
    else if(model.orderStatus == '2'){
      detail = '待服务';
    }
    else if(model.orderStatus == '3'){
      detail = '服务已完成';
    }
    else if(model.orderStatus == '4'){
      detail = '已取消';
    }
    else if(model.orderStatus == '5'){
      detail = '已退款';
    }
    return detail;
  }

}
