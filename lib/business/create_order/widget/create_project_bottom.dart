import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/util/common_util_zh.dart';
import '../../../tools/widgets/tap_container.dart';
import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 


typedef CreateProjectBottomBlock = Function();

class CreateProjectBottom extends StatelessWidget {

  Projects project;
  int number;
  CreateProjectBottomBlock block;

  CreateProjectBottom({super.key,required this.project,required this.block,required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height:CommonUtilZH().bottomSpacing(context, 10.w) + 10.w + 42.w,
      alignment: Alignment.topCenter,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20.r,right: 20.r,top: 10.r),
      child: Row(
         children: [
           Text.rich(
             TextSpan(
                 children: [
                   TextSpan(
                     text: '¥',
                     style: TextStyle(
                       fontSize: 15.sp,
                       fontWeight: FontWeight.w600,
                       color: const Color(0xFFD81E06),
                     ),
                   ),
                   TextSpan(
                     text: '${(project.price ?? 0) * number}',
                     style: TextStyle(
                       fontSize: 20.sp,
                       fontWeight: FontWeight.w600,
                       color: const Color(0xFFD81E06),
                     ),
                   ),
                 ]
             ),
           ),
           const Spacer(flex: 1,),
           TapContainer(
             childWidget: Container(
               width: 80.r,
               height: 28.r,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(4.r)),
                   color: Colors.blueAccent
               ),
               alignment: Alignment.center,
               child: Text(
                 "预约并支付",
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
    );
  }
}
