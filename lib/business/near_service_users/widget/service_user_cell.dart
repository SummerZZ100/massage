import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../../../tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 


typedef ServiceUserCellBlock = Function();

class ServiceUserCell extends StatelessWidget {

  ServiceUsers serviceUser;
  ServiceUserCellBlock block;

  ServiceUserCell({super.key,required this.serviceUser,required this.block});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidgetZH(
            imageUrl: serviceUser.headSrc,
            imageWidth: 90.r,
            imageHeight: 90.r,
            style: 1,
            fit:BoxFit.cover,
            radius: 10.r,
          ),
          SizedBox(width: 10.r,),
          Expanded(child:
           SizedBox(
             height: 90.r,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Text(
                       serviceUser.nickname ?? "",
                       style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 15.sp,
                         color: const Color(0xFF333333),
                         decoration: TextDecoration.none,
                       ),
                     ),
                     const Spacer(flex: 1,),
                     Text(
                       '${serviceUser.distance}km',
                       style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 12.sp,
                         color: const Color(0xFF898989),
                         decoration: TextDecoration.none,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   children: [
                     Icon(
                       Icons.star,
                       color: const Color(0xFFD9031D),
                       size: 18.r,
                     ),
                     Text(
                       ' ${serviceUser.score}',
                       style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 12.sp,
                         color: const Color(0xFF323232),
                         decoration: TextDecoration.none,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   children: [
                     Text.rich(
                       TextSpan(
                           children: [
                             TextSpan(
                               text: '总接单${serviceUser.orderNum}+',
                               style: TextStyle(
                                 fontSize: 12.sp,
                                 color: const Color(0xFF898989),
                               ),
                             ),
                           ]
                       ),
                     ),
                     const Spacer(flex: 1,),
                     TapContainer(
                       childWidget: Container(
                         width: 70.r,
                         height: 22.r,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(4.r)),
                             color: Colors.blueAccent
                         ),
                         alignment: Alignment.center,
                         child: Text(
                           "去下单",
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
                 )
               ],
             )),
           )
        ],
      ),
    );
  }
}
