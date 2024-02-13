import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Coupon.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 


typedef CouponCellBlock = Function();

class CouponCell extends StatelessWidget {

  Coupon coupon;
  CouponCellBlock block;

  CouponCell({super.key,required this.coupon,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.r,right: 15.r,top: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:
           SizedBox(
             height: 80.r,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   coupon.title ?? "",
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 15.sp,
                     color: const Color(0xFF333333),
                     decoration: TextDecoration.none,
                   ),
                 ),
                 Text(
                   coupon.desc ?? "",
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 12.sp,
                     color: const Color(0xFF323232),
                     decoration: TextDecoration.none,
                   ),
                 ),
                 Text(
                   coupon.note ?? "",
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 12.sp,
                     color: const Color(0xFF898989),
                     decoration: TextDecoration.none,
                   ),
                 ),

               ],
             )),
           ),
          SizedBox(
            height: 80.r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Offstage(
                      offstage: !(coupon.had ?? false),
                      child: Image.asset(
                          "${SystemConfig.resource}coupon_have.png",
                        width: 60.r,
                        height: 60.r,
                      ),
                    ),
                    SizedBox(
                        height: 60.r,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "¥${coupon.money}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: const Color(0xFFD92C19),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            TapContainer(childWidget: Text(
                              (coupon.had ?? false) ? "已领取" : "立即领取",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: const Color(0xFF898989),
                                decoration: TextDecoration.none,
                              ),
                            ), clickBlock: (){
                               if(!(coupon.had ?? false)){
                                 block();
                               }
                            },),
                            SizedBox(height: 5.r,)
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
