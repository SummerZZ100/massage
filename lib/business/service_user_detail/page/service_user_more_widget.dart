import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../../../tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

/*
* 回调方法  type 1: 拉黑  2:举报
* */
typedef ServiceUserMoreWidgetBlock = Function(int type);

class ServiceUserMoreWidget extends StatelessWidget {

  ServiceUserMoreWidgetBlock block;
  ServiceUserMoreWidget({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.r,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r), topRight: Radius.circular(4.r)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 18.r,),
          Text(
            "更多",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 40.r,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TapContainer(childWidget:
               Column(
                 children: [
                   Container(
                     width: 60.r,
                     height: 60.r,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(30.r)),
                       color: const Color(0x664985FD)
                     ),
                     child: Image.asset(
                       "${SystemConfig.resource}go_black_ic.png"
                     )
                   ),
                   SizedBox(height: 4.r,),
                   Text(
                     "拉黑",
                     style: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 15.sp,
                       color: const Color(0xFF333333),
                       decoration: TextDecoration.none,
                     ),
                   )
                 ],
               ),
                 clickBlock: (){
                   block(1);
                   Navigator.pop(context);
                 },
               ),
              SizedBox(width: 100.r,),
              TapContainer(childWidget:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          color: const Color(0x664985FD)
                      ),
                      child: Image.asset(
                          "${SystemConfig.resource}go_report_ic.png"
                      )
                  ),
                  SizedBox(height: 4.r,),
                  Text(
                    "举报",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: const Color(0xFF333333),
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),clickBlock: (){
                block(2);
                Navigator.pop(context);
              },)
            ],
          ),
          SizedBox(height: 40.r,),
          TapContainer(
            childWidget: Container(
              width: ScreenUtil().screenWidth - 80.r,
              height: 30.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  color: Colors.blueAccent
              ),
              alignment: Alignment.center,
              child: Text(
                "取消",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            clickBlock: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
