import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

typedef CreateServiceWidgetBlock = Function();

class CreateServiceWidget extends StatelessWidget {

  String name;
  String projectName;
  String headerUrl;
  DateTime? serviceTime;//服务时间
  CreateServiceWidgetBlock block;

  CreateServiceWidget({super.key,required this.name,
  required this.headerUrl,required this.projectName,required this.serviceTime,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        children: [
          // TapContainer(
          //   childWidget: Row(
          //     children: [
          //       Container(
          //         width: 80.r,
          //         padding: EdgeInsets.only(right: 10.r),
          //         alignment: Alignment.centerRight,
          //         child: Text(
          //           '服务时间',
          //           style: TextStyle(
          //             color: const Color(0xFF333333),
          //             fontWeight: FontWeight.w600,
          //             fontSize: 15.sp,
          //           ),
          //         ),
          //       ),
          //       const Spacer(flex: 1,),
          //       Text(
          //         _serviceTimeStr(),
          //         style: TextStyle(
          //           fontWeight: FontWeight.w500,
          //           fontSize: 14.sp,
          //           color: const Color(0xFFFF0000),
          //         ),
          //       ),
          //       const Icon(
          //         Icons.chevron_right,
          //         color: Color(0xFF333333),
          //       )
          //     ],
          //   ),
          //   clickBlock: (){
          //     block();
          //   },
          // ),
          // Padding(padding: EdgeInsets.only(top: 10.r,bottom: 10.r),
          //   child: const Divider(
          //     height: 1,
          //     color: Color(0xFFDADADA),
          //   ),),
          Row(
            children: [
              Container(
                width: 80.r,
                padding: EdgeInsets.only(right: 10.r),
                alignment: Alignment.centerRight,
                child: Text(
                  '服务人员',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              const Spacer(flex: 1,),
              ImageWidgetZH(
                imageUrl: headerUrl,
                imageWidth: 20.r,
                imageHeight: 20.r,
                style: 1,
                radius: 10.r,
                fit:BoxFit.cover,
              ),
              Text(
                '  $name  $projectName',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _serviceTimeStr(){

    String time = '';
    if(serviceTime != null){

      String hourStr = '';
      if(serviceTime!.hour <= 9){
        hourStr = '0${serviceTime!.hour}';
      }
      else{
        hourStr = '${serviceTime!.hour}';
      }
      String minuteStr = '';
      if(serviceTime!.minute <= 9){
        minuteStr = '0${serviceTime!.minute}';
      }
      else{
        minuteStr = '${serviceTime!.minute}';
      }

      time = ' ${serviceTime!.month}月${serviceTime!.day}日  $hourStr:$minuteStr';
  }

    return time;


  }



}
