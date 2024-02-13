import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/6
///  describtion 

/*
* 回调方法
* type 1:特价项目  2:附近技师  3:优惠券
* */
typedef SpecialHomeCellBlock = Function(int type);

class SpecialHomeCell extends StatelessWidget {

  SpecialHomeCellBlock block;
  SpecialHomeCell({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(left: 18.r,top: 12.r,bottom: 12.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TapContainer(
            childWidget: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                    '${SystemConfig.resource}tejiaxiangmu.png',
                    width: 150.r,
                    height: 120.r,
                    fit: BoxFit.fill,
                ),
                Text(
                  '找服务',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                )
              ],
            ),
            clickBlock: (){
              block(1);
            },
          ),
          SizedBox(width: 12.r,),
          Column(
            children: [
              TapContainer(
                childWidget: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      '${SystemConfig.resource}fujinjishi.png',
                      width: ScreenUtil().screenWidth - 36.r - 150.r - 12.r,
                      height: 55.r,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      '找技师',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    )
                  ],
                ),
                clickBlock: (){
                  block(2);
                },
              ),
              SizedBox(height: 10.r,),
              TapContainer(
                childWidget: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      '${SystemConfig.resource}youhuiquan.png',
                      width: ScreenUtil().screenWidth - 36.r - 150.r - 12.r,
                      height: 55.r,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      '优惠券',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    )
                  ],
                ),
                clickBlock: (){
                  block(3);
                },
              )
            ],
          )
        ],
      ),

    );
  }
}
