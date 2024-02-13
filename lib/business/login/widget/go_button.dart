import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  登录按钮
/*
* 回调方法
* */
typedef GoButtonBlock = Function();

class GoButton extends StatelessWidget {

  bool? canClick;
  GoButtonBlock? block;

  GoButton({Key? key,this.block, this.canClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: TapContainer(
        childWidget: Container(
          width: ScreenUtil().screenWidth - 60.r,
          height: 50.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: (canClick ?? false) ? ColorValue.blueColor() : const Color(0x664C8EF8),
          ),
          alignment: Alignment.center,
          child: Text(
            '验证并登录',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
        ),
        clickBlock: (){
          if(canClick == true){
            if(block != null){
              block!();
            }
          }
        },
      ),
    );
  }
}

