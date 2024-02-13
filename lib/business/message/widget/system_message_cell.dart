import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/message_model.dart';

///  create by zhangxiaosong on 2023/9/10
///  describtion 

class SystemMessageCell extends StatelessWidget {

  MessageModel model;
  SystemMessageCell({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.r,),
        Text(
          model.createTime ?? "",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: const Color(0xFF333333),
            decoration: TextDecoration.none,
          ),
          maxLines: 1,
        ),
        Container(
          width: ScreenUtil().screenWidth,
          margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 15.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white
          ),
          padding: EdgeInsets.all(14.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10.r,),
              Text(
                model.detail ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 2,
              ),
            ],
          ),
        )
      ],
    );
  }
}
