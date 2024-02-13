import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../middle/color_value.dart';
import '../model/Report_content_model.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class ReportContentCell extends StatelessWidget {

  ReportContentModel model;
  ReportContentCell({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 50.r,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.r,right: 15.r),
      child: Column(
        children: [
           Expanded(
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Expanded(child: Text(
                   model.title ?? "",
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 16.sp,
                     color: const Color(0xFF333333),
                     decoration: TextDecoration.none,
                   ),
                 )
                 ),
                 (model.selected ?? false) ? Icon(
                   Icons.check_circle_outline,
                   color: ColorValue.blueColor(),
                   size: 16.r,
                 ) : Icon(
                   Icons.radio_button_unchecked_outlined,
                   color: const Color(0xffDADADA),
                   size: 16.r,
                 )
               ],
             ),
           ),
          const Divider(
            color: Color(0xFFAAAAAA),
            height: 1,
          ),
        ],
      ),
    );
  }
}
