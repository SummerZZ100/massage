import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import 'mine_little_item_widget.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

/*
* 回调方法
* type 1:全部订单  2:待接单  3:待服务  4:已完成  5:退款/售后
* */
typedef MineOrderWidgetBlock = Function(int type);

class MineOrderWidget extends StatelessWidget {

  MineOrderWidgetBlock block;
  MineOrderWidget({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 5.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        children: [
          TapContainer(childWidget: Row(
            children: [
              Expanded(child: Text(
                "我的订单",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
              ),),
              const Icon(
                Icons.chevron_right,
                color: const Color(0xFF333333),
              )
            ],
          ),
            clickBlock: (){
              block(1);
            },
          ),
          SizedBox(height: 15.r,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MineLittleItemWidget(
                title: '待接单',
                block: (){
                    block(2);
                },
              ),
              MineLittleItemWidget(
                title: '待服务',
                block: (){
                  block(3);
                },
              ),
              MineLittleItemWidget(
                title: '已完成',
                block: (){
                  block(4);
                },
              ),
              MineLittleItemWidget(
                title: '退款/售后',
                block: (){
                  block(5);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
