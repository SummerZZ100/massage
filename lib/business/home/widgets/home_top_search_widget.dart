import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/17
///  describtion 

typedef HomeTopSearchWidgetBlock = Function();

class HomeTopSearchWidget extends StatelessWidget {

  String city;
  HomeTopSearchWidgetBlock block;
  HomeTopSearchWidget({super.key,required this.city,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2,top: 10.r,bottom: 10.r),
      child: Row(
        children: [
          SizedBox(width: 90.r,
          child: Text(
            city.isNotEmpty ? city : '当前城市',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),),
          TapContainer(
            childWidget: Container(
              width: ScreenUtil().screenWidth - 110.r,
              height: 30.r,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.r,right: 10.r),
                    child: Image.asset(
                        "${SystemConfig.resource}search_p.png"
                    ),),
                  Text(
                    '请输入关键词',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: const Color(0xFF787878),
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
            clickBlock: (){
              block();
            },
          )
        ],
      ),
    );
  }
}
