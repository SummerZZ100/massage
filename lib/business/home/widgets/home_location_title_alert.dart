import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../../../tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/7
///  describtion 

typedef HomeLocationTitleAlertBlock = Function();

class HomeLocationTitleAlert extends StatelessWidget {

  HomeLocationTitleAlertBlock block;
  HomeLocationTitleAlert({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          height: 38.r,
        ),
        Padding(padding: EdgeInsets.only(left: 25.r),
        child: Image.asset("${SystemConfig.resource}location_background.png",
          width: ScreenUtil().screenWidth - 50.r,
          height: 38.r,
          fit: BoxFit.fill,
            ),),
        Container(
          width: ScreenUtil().screenWidth,
          height: 38.r,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 40.r,top: 10.r),
          child: Row(
            children: [
              SizedBox(width: 40.r,),
              Expanded(child: Text(
                "开启定位权限",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              )),
              TapContainer(
                childWidget: Container(
                  width: 50.r,
                  height: 20.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      color: Colors.blueAccent
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "开启",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                clickBlock: (){
                  block();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
