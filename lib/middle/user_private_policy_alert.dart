import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/middle/web_view/page/webview_zh_page.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../tools/util/shared_preference_zh.dart';
import 'color_value.dart';


/**
 *  个人信息保护指引
 */

typedef UserPrivatePolicyAlertBlock = Function();

class UserPrivatePolicyAlert extends StatefulWidget {

  UserPrivatePolicyAlertBlock? block;

  UserPrivatePolicyAlert({Key? key, this.block}) : super(key: key);

  @override
  _UserPrivatePolicyAlertState createState() => _UserPrivatePolicyAlertState();

}

class _UserPrivatePolicyAlertState extends State<UserPrivatePolicyAlert> {

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
  void dispose(){
    serviceTapRecognizer.dispose();
    privateTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double widgetWidth = 300.r;
    double widgetHeight = 300.r;

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
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  Text(
                    '隐私政策',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorValue.textColor1(),
                    ),
                  ),
                  SizedBox(height: 8.w,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: '    尊敬的用户，为了保护您的个人信息和权益，使用我们的应用程序前，请阅读并同意我们的 ',
                              style: TextStyle(
                                  color: const Color(0xff7F7F7F),
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
                              text: '和',
                              style: TextStyle(
                                  color: const Color(0xff7F7F7F),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.5
                              ),
                            ),
                            TextSpan(
                              text: '《隐私政策》',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.5
                              ),
                              recognizer: privateTapRecognizer,
                            ),
                            TextSpan(
                              text: '。这些协议规定了您使用我们服务时的权责，以及我们对您个人信息的收集和使用方式。点击同意表示您已经充分了解并同意遵守这些条款。',
                              style: TextStyle(
                                  color: const Color(0xff7F7F7F),
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
                      SizedBox(width: 10.r,),
                      TapContainer(
                        childWidget: Container(
                          width: (widgetWidth - 80.r)/2,
                          height: 30.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.r)),
                            color: const Color(0xffF3F3F3),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '不同意',
                            style: TextStyle(
                                color: ColorValue.textColor3(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp
                            ),
                          ),
                        ),
                        clickBlock: (){
                          _notSureClick();
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
                            '同意',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp
                            ),
                          ),
                        ),
                        clickBlock: (){
                          _sureClick();
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

    if(type == 1){//用户协议
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: 'https://imgs.ituiuu.cn/cdn/pages/useagreement.html',
        title: '用户协议',
        showLeftBtn: true,
        inHomeTab: false,
      ));
    }
    else if (type == 2){//隐私政策
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: 'https://imgs.ituiuu.cn/cdn/pages/privacy.html',
        title: '隐私政策',
        showLeftBtn: true,
        inHomeTab: false,
      ));

    }

  }

  /*
  * 同意
  * */
  _sureClick(){

    SharedPreferenceZH.instance.saveOffstagePrivacyPolicy(offstage: true);

    if(widget.block != null){
      widget.block!();
    }

    Navigator.pop(context);
  }

  /*
  * 暂不使用
  * */
  _notSureClick(){
    exit(0);
  }

}


