import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/11
///  describtion 

/*
* clickT  :  1: 家   2: 公司   3: 默认
* */
typedef EditTypeWidgetBlock = Function(int clickT);

class EditTypeWidget extends StatelessWidget {

  int type = 0;
  bool isDefault = false;
  EditTypeWidgetBlock block;

  EditTypeWidget({super.key,required this.type,required this.isDefault,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '地址标签',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(width: 15.r,),
              TapContainer(childWidget: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    border: Border.all(color:const Color(0xFF999999),width: 1),
                    color: type == 1 ? ColorValue.blueColor() : Colors.white
                ),
                alignment: Alignment.center,
                child: Text(
                  '   家   ',
                  style: TextStyle(
                    color: type == 1 ? Colors.white : const Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                  ),
                ),
              ), clickBlock: (){
                block(1);
              },),
              SizedBox(width: 15.r,),
              TapContainer(childWidget: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    border: Border.all(color:const Color(0xFF999999),width: 1),
                    color: type == 2 ? ColorValue.blueColor() : Colors.white
                ),
                alignment: Alignment.center,
                child: Text(
                  '   公司   ',
                  style: TextStyle(
                    color: type == 2 ? Colors.white : const Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                  ),
                ),
              ),clickBlock: (){
                block(2);
              },)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 14.r,bottom: 8.r),
            child:const Divider(
              height: 1,
              color: Color(0xFFAAAAAA),
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child:  Text(
                '设置为默认地址',
                style: TextStyle(
                  color: const Color(0xFF999999),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              )),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: isDefault,
                  activeColor: ColorValue.blueColor(),
                  onChanged: (value){
                    block(3);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
