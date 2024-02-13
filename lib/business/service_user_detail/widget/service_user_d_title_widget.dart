import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class ServiceUserDTitleWidget extends StatelessWidget {

  ServiceUsers serviceUser;
  ServiceUserDTitleWidget({super.key,required this.serviceUser});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 15.r,right: 15.r,top: 12.r,bottom: 18.r),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
             Expanded(child: Text(
               serviceUser.nickname ?? "",
               style: TextStyle(
                 fontWeight: FontWeight.w500,
                 fontSize: 15.sp,
                 color: const Color(0xFF333333),
                 decoration: TextDecoration.none,
               ),
             )),
             Text(
               "小于${serviceUser.distance ?? 0}km",
               style: TextStyle(
                 fontWeight: FontWeight.w500,
                 fontSize: 11.sp,
                 color: const Color(0xFF333333),
                 decoration: TextDecoration.none,
               ),
             ),
           ],
         ),
         SizedBox(height: 5.r,),
         Row(
           children: [
             Icon(
               Icons.star,
               color: const Color(0xFFD9031D),
               size: 18.r,
             ),
             Text.rich(
               TextSpan(
                   children: [
                     TextSpan(
                       text: ' ${serviceUser.score}',
                       style: TextStyle(
                         fontSize: 12.sp,
                         color: const Color(0xFF323232),
                       ),
                     ),
                     TextSpan(
                       text: '     总接单${serviceUser.orderNum}+',
                       style: TextStyle(
                         fontSize: 11.sp,
                         color: const Color(0xFF646464),
                       ),
                     ),
                   ]
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
             fontSize: 13.sp,
             color: const Color(0xFF5A5A5A),
             decoration: TextDecoration.none,
           ),
         ),
       ],
     ),);
  }

  _tagStr(){
    String tag = '';

    if((serviceUser.constellation?.length ?? 0) > 0){
      tag += '星座: ${serviceUser.constellation}   ';
    }
    if((serviceUser.nation?.length ?? 0) > 0){
      tag += '民族: ${serviceUser.nation}   ';
    }
    if((serviceUser.height ?? 0) > 0){
      tag += '身高: ${serviceUser.height}cm   ';
    }
    if((serviceUser.weight ?? 0) > 0){
      tag += '体重: ${serviceUser.weight}kg   ';
    }


    return tag;
  }

}
