import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  登录 标题
///

/*
* 回调方法
* type 1：勾选  2：用户协议  3：隐私政策
* */
typedef LoginBottomAlertWidgetBlock = Function(int type);

class LoginBottomAlertWidget extends StatelessWidget {

  bool? hasChecked;//是否已经选中
  LoginBottomAlertWidgetBlock? block;

  TapGestureRecognizer? sureTapRecognizer;//已阅读点击
  TapGestureRecognizer? privateTapRecognizer;//隐私政策点击
  TapGestureRecognizer? serviceTapRecognizer;//服务条款点击

  LoginBottomAlertWidget({Key? key,this.hasChecked,this.block}) : super(key: key){

    sureTapRecognizer = TapGestureRecognizer();
    privateTapRecognizer = TapGestureRecognizer();
    serviceTapRecognizer = TapGestureRecognizer();

    sureTapRecognizer!.onTap = () {//已阅读点击
      if(block != null){
        block!(1);
      }
    };
    privateTapRecognizer!.onTap = () {//隐私政策
      if(block != null){
        block!(3);
      }
    };

    serviceTapRecognizer!.onTap = () {//用户协议
      if(block != null){
        block!(2);
      }
    };

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w,top: 20.w,right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TapContainer(
          childWidget: SizedBox(
            width: 16.r,
            height: 16.r,
            child: (hasChecked ?? false) ? Icon(
              Icons.check_circle_outline,
              color: ColorValue.blueColor(),
              size: 16.r,
            ) : Icon(
              Icons.radio_button_unchecked_outlined,
              color: const Color(0xffDADADA),
              size: 16.r,
            ),
          ),
          clickBlock: (){
            if(block != null){
              block!(1);
            }
          },
        ),
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: ' 已阅读并同意',
                style: TextStyle(
                  color: const Color(0xFF6E6E6E),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                ),
                recognizer: sureTapRecognizer,
              ),
              TextSpan(
                text: '《用户协议》',
                style: TextStyle(
                  color: ColorValue.blueColor(),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                ),
                recognizer: serviceTapRecognizer,
              ),
              TextSpan(
                text: '和',
                style: TextStyle(
                  color: const Color(0xFF6E6E6E),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                ),
              ),
              TextSpan(
                text: '《隐私政策》',
                style: TextStyle(
                  color: ColorValue.blueColor(),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                ),
                recognizer: privateTapRecognizer,
              ),

            ],
          ),
          textAlign: TextAlign.start,
        )
      ],
    ),);

  }
  
}


