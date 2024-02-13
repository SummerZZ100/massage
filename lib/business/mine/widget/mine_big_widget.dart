import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import 'mine_little_item_widget.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

/*
* 回调方法
* type 1:我的订单 2:我的钱包
* */
typedef MineBigWidgetBlock = Function(int type);

class MineBigWidget extends StatelessWidget {

  MineBigWidgetBlock block;
  MineBigWidget({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 5.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          // color: Colors.white
      ),
      // padding: EdgeInsets.all(14.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TapContainer(
            childWidget: Stack(
              children: [
                Image.asset(
                  "${SystemConfig.resource}my_order_logo.png"
                ),
                Positioned(
                  right: 14.r,
                    top: 20.r,
                    child: Text(
                      "我的订单",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF333333),
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                    )
                ),
              ],
            ),
            clickBlock: (){
              block(1);
            },
          ),
          TapContainer(
            childWidget: Stack(
              children: [
                Image.asset(
                    "${SystemConfig.resource}my_wallet_logo.png"
                ),
                Positioned(
                    right: 14.r,
                    top: 20.r,
                    child: Text(
                      "我的钱包",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF333333),
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                    )
                ),
              ],
            ),
            clickBlock: (){
              block(2);
            },
          ),
        ],
      ),
    );
  }
}
