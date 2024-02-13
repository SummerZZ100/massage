import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/middle/system_config.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class MessageTypeCell extends StatelessWidget {

  int type;//1. 系统消息  2.服务通知  3.店铺客服
  MessageTypeCell({super.key,required this.type});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              _typeImagePath()
          ),
          SizedBox(width: 10.r,),
          Expanded(child:
          Text(
            _typeTitle(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
          )
        ],
      ),
    );
  }

  _typeImagePath(){
    String path = '';
    if(type == 1){
      path = '${SystemConfig.resource}system_message.png';
    }
    else if(type == 2){
      path = '${SystemConfig.resource}service_message.png';
    }
    else if(type == 3){
      path = '${SystemConfig.resource}shop_message.png';
    }
    return path;
  }

  _typeTitle(){
    String title = '';
    if(type == 1){
      title = '系统消息';
    }
    else if(type == 2){
      title = '服务通知';
    }
    else if(type == 3){
      title = '店铺客服';
    }
    return title;
  }

}
