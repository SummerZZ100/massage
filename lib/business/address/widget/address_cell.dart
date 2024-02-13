import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../middle/color_value.dart';
import '../model/Contact_address_model.dart';

///  create by zhangxiaosong on 2023/9/11
///  describtion 

/*
* 回调方法
* type 1: 编辑  2:设为默认  3:删除
* */
typedef AddressCellBlock = Function(int type);

class AddressCell extends StatelessWidget {

  ContactAddressModel model;
  AddressCellBlock block;
  AddressCell({super.key,required this.block,required this.model});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 15.r,right: 15.r,top: 10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             children: [
               Expanded(child:
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "${model.contactName}   ${model.contactPhone}",
                     style: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 13.sp,
                       color: const Color(0xFF333333),
                       decoration: TextDecoration.none,
                     ),
                     maxLines: 1,
                   ),
                   Text(
                     "${model.city} ${model.addressDetail}",
                     style: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 12.sp,
                       color: const Color(0xFF333333),
                       decoration: TextDecoration.none,
                     ),
                     maxLines: 1,
                   )
                 ],
               )),
               Text(
                 " | ",
                 style: TextStyle(
                   fontWeight: FontWeight.w500,
                   fontSize: 14.sp,
                   color: const Color(0xFF333333),
                   decoration: TextDecoration.none,
                 ),
                 maxLines: 1,
               ),
               TapContainer(childWidget: Padding(
                 padding: EdgeInsets.only(right: 8.r),
                 child: Image.asset(
                     "${SystemConfig.resource}edit_logo.png"
                 ),
               ),clickBlock: (){
                  block(1);
               },)
             ],
           ),
          Padding(padding: EdgeInsets.only(top: 8.r,bottom: 8.r),
            child:const Divider(
              height: 1,
              color: Color(0xFFAAAAAA),
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TapContainer(
                childWidget: SizedBox(
                  width: 150.r,
                  child: Row(
                    children: [
                      Icon(
                        (model.isDefault ?? false) ? Icons.radio_button_checked : Icons.radio_button_unchecked_outlined,
                        color: (model.isDefault ?? false) ? ColorValue.blueColor() : const Color(0xFF999999),
                        size: 15,
                      ),
                      Text(
                        "默认地址",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: const Color(0xFF333333),
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                clickBlock: (){
                  block(2);
                },
              ),
              TapContainer(childWidget: Text(
                " 删除 ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
              ), clickBlock: (){
                block(3);
              },)
            ],
          )
        ],
      ),
    );
  }
}
