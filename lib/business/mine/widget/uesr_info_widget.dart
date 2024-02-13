import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

/*
* 回调方法 type 1: 编辑信息  2:关注  3:粉丝
* */
typedef UserInfoWidgetBlock = Function(int type);

class UserInfoWidget extends StatelessWidget {

  UserInfoWidgetBlock block;
  UserInfoWidget({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18.r,right: 18.r,top: 15.r,bottom: 2.r),
      child: Row(
        children: [
          TapContainer(
            childWidget: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(22.r)),
              child: Container(
                color: Colors.white,
                child: UserDataLocalTool.instance.obtainHeader().isNotEmpty ? Image.memory(
                  Uint8List.fromList(UserDataLocalTool.instance.obtainHeader()),
                  fit: BoxFit.cover,
                  width: 44.r,
                  height: 44.r,
                ) : Image.asset(
                  "${SystemConfig.resource}touxiang.png",
                  width: 44.r,
                  height: 44.r,
                ),
              ),
            ),
            clickBlock: (){
              block(1);
            },
          ),
          SizedBox(width: 10.r,),
          Expanded(child: SizedBox(
            height: 44.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TapContainer(childWidget: Text(
                  UserDataLocalTool.instance.obtainUserName(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: const Color(0xFF333333),
                    decoration: TextDecoration.none,
                  ),
                  maxLines: 1,
                ), clickBlock: (){
                  block(1);
                },),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(
                      UserDataLocalTool.instance.obtainSignName(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: const Color(0xFF333333),
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                    )),
                    SizedBox(width: 10.r,),
                    TapContainer(
                      childWidget: Text(
                        "关注：${UserDataLocalTool.instance.obtainCareNumber()}      ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: const Color(0xFF333333),
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                      ),
                      clickBlock: (){
                        block(2);
                      },
                    ),
                    TapContainer(
                      childWidget: Text(
                        "粉丝：${UserDataLocalTool.instance.obtainFansNumber()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: const Color(0xFF333333),
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                      ),
                      clickBlock: (){
                        block(3);
                      },
                    ),
                    SizedBox(width: 40.r,),
                  ],
                ),

              ],
            ),
          ))
        ],
      ),
    );
  }
}
