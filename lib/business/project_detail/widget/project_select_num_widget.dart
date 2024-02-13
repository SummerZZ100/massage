import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

typedef ProjectSelectNumWidgetBlock = Function(int number);

class ProjectSelectNumWidget extends StatelessWidget {

  Projects project;
  int number;
  ProjectSelectNumWidgetBlock block;
  ProjectSelectNumWidget({super.key,required this.project,required this.number,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18.r,right: 18.r,top: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "购买数量",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(flex: 1,),
              TapContainer(
                childWidget: Container(
                  width: 18.r,
                  height: 18.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.r)),
                    color: const Color(0xFFD0D0D0)
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '-',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                clickBlock: (){
                  // if(number > 1){
                  //   number -= 1;
                  //   block(number);
                  // }
                },
              ),
              Text(
                '  $number  ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF646464),
                  decoration: TextDecoration.none,
                ),
              ),
              TapContainer(
                childWidget: Container(
                  width: 18.r,
                  height: 18.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.r)),
                      color: const Color(0xFFD0D0D0)
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                clickBlock: (){
                  // if(number < 9){
                  //   number += 1;
                  //   block(number);
                  // }
                },
              )
            ],
          ),
          SizedBox(height: 15.r,),
          const Divider(
            height: 1,
            color: Color(0xFFDADADA),
          ),
        ],
      ),
    );
  }


}
