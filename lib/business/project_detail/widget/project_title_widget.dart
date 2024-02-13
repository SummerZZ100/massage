import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class ProjectTitleWidget extends StatelessWidget {

  Projects project;
  ProjectTitleWidget({super.key,required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 15.r,right: 15.r,top: 12.r,bottom: 18.r),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           project.name ?? "",
           style: TextStyle(
             fontWeight: FontWeight.w500,
             fontSize: 15.sp,
             color: const Color(0xFF333333),
             decoration: TextDecoration.none,
           ),
         ),
         SizedBox(height: 5.r,),
         Row(
           children: [
             Text.rich(
               TextSpan(
                   children: [
                     TextSpan(
                       text: '¥${project.price}',
                       style: TextStyle(
                         fontSize: 14.sp,
                         color: const Color(0xFFD81E06),
                       ),
                     ),
                     TextSpan(
                       text: '  ${project.time}分钟',
                       style: TextStyle(
                         fontSize: 11.sp,
                         color: const Color(0xFF646464),
                       ),
                     ),
                   ]
               ),
             ),
             const Spacer(flex: 1,),
             Text(
               "已售${project.orderNum}单",
               style: TextStyle(
                 fontWeight: FontWeight.w500,
                 fontSize: 11.sp,
                 color: const Color(0xFF333333),
                 decoration: TextDecoration.none,
               ),
             ),
           ],
         ),
         Padding(padding: EdgeInsets.only(top: 6.r,bottom: 10.r),
         child:const Divider(
           height: 1,
           color: Color(0xFFAAAAAA),
         ),),
         Text(
           _tagStr(),
           style: TextStyle(
             fontWeight: FontWeight.w500,
             fontSize: 14.sp,
             color: const Color(0xFF5A5A5A),
             decoration: TextDecoration.none,
           ),
         ),
       ],
     ),);
  }

  _tagStr(){
    String tag = '';

    if((project.tags?.length ?? 0) > 0){
      for(int i = 0;i < project.tags!.length;i++){
        String t = project.tags![i];
        tag += '$t    ';
      }
    }

    return tag;
  }

}
