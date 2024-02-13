import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 



class ProjectDesWidget extends StatelessWidget {

  Projects project;

  ProjectDesWidget({super.key,required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 5.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "服务内容",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 8.r,),
          Text(
            "服务时长：${project.time}分钟         服务姿势：${project.posture ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFFFDC23E),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 8.r,),
          Text(
            "功效介绍：${project.efficacyIntroduction ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF5A5A5A),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 8.r,),
          Text(
            "不宜人群：${project.noUsers ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF5A5A5A),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 8.r,),
          Text(
            "服务流程：${project.serviceProcess ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF5A5A5A),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 8.r,),
          Text(
            "用品提供：${project.suppliesProvided ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF5A5A5A),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
