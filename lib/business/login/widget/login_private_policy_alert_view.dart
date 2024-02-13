
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../middle/web_view/page/webview_zh_page.dart';


/**
 *  个人信息保护指引
 */

/*
* 回调方法
* type 1：不同意  2：同意并登录
* */
typedef LoginPrivatePolicyAlertViewBlock = Function(int type);

class LoginPrivatePolicyAlertView extends StatefulWidget {

  LoginPrivatePolicyAlertViewBlock? block;

  LoginPrivatePolicyAlertView({Key? key, this.block}) : super(key: key);

  @override
  State<LoginPrivatePolicyAlertView> createState() => _LoginPrivatePolicyAlertViewState();

}

class _LoginPrivatePolicyAlertViewState extends State<LoginPrivatePolicyAlertView> {

  TapGestureRecognizer serviceTapRecognizer = TapGestureRecognizer();
  TapGestureRecognizer privateTapRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceTapRecognizer.onTap = () {//用户服务协议
      _goAgreementPage(1);
    };

    privateTapRecognizer.onTap = () {//隐私政策
      _goAgreementPage(2);
    };

  }

  @override
  Widget build(BuildContext context) {

    double widgetWidth = ScreenUtil().screenWidth - 100.w;
    double widgetHeight = (ScreenUtil().screenWidth - 100.w)*2/3;

    return Material(//创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center( //保证控件居中效果
        child: SizedBox(
            width: widgetWidth,
            height: widgetHeight,
            child: Container(
              width: widgetWidth,
              height: widgetHeight,
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Text(
                    '温馨提示',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 8.w,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: '需要同意',
                              style: TextStyle(
                                  color: const Color(0xff333333),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.5
                              ),
                            ),
                            TextSpan(
                              text: '《用户协议》',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.5
                              ),
                              recognizer: serviceTapRecognizer,
                            ),
                            TextSpan(
                              text: '、《隐私政策》',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.5
                              ),
                              recognizer: privateTapRecognizer,
                            ),
                            TextSpan(
                              text: '才能登录',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.5
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.w,),
                  Row(
                    children: [
                      SizedBox(width: 10.w,),
                      TapContainer(
                        childWidget: Container(
                          width: (widgetWidth - 80.w)/2,
                          height: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.w)),
                            color: Color(0xFFF3F3F3),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '不同意',
                            style: TextStyle(
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp
                            ),
                          ),
                        ),
                        clickBlock: (){
                          Navigator.pop(context);
                          if(widget.block != null){
                            widget.block!(1);
                          }
                        },
                      ),
                      SizedBox(width: 10.r,),
                      TapContainer(
                        childWidget: Container(
                          width: (widgetWidth - 80.r)/2,
                          height: 30.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.r)),
                            color: Colors.blueAccent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '同意并登录',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp
                            ),
                          ),
                        ),
                        clickBlock: (){
                          Navigator.pop(context);
                          if(widget.block != null){
                            widget.block!(2);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );

  }

  /*
  * 跳转到 用户协议 / 隐私政策
  * */
  _goAgreementPage(int type){

    if(type == 1){
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: 'https://xmcdn.hongxi.online/yonghuxieyi.html',
        title: '用户协议',
        showLeftBtn: true,
        inHomeTab: false,
      ));
    }
    else if (type == 2){
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: 'https://xmcdn.hongxi.online/yinsixieyi.html',
        title: '隐私政策',
        showLeftBtn: true,
        inHomeTab: false,
      ));
    }

  }

}


