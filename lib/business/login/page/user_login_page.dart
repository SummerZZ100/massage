
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/login/logic/user_login_logic.dart';
import 'package:massage/middle/network/request_interface.dart';
import 'package:massage/middle/shanyan_tool/shanyan_tool.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/middle/widget/alert_app_widget.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/web_view/page/webview_zh_page.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../main_tab/model/mian_tab_change_tool.dart';
import '../widget/code_edit_view.dart';
import '../widget/go_button.dart';
import '../widget/login_bottom_alert_widget.dart';
import '../widget/phone_edit_view.dart';

///  登录

class UserLoginPage extends StatefulWidget {

  const UserLoginPage({Key? key}) : super(key: key);

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
  
}

class _UserLoginPageState extends State<UserLoginPage> {

  late UserLoginLogic controller;
  bool? startPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UserLoginLogic());
    startPage = Get.arguments;
    _autoPhoneLogin();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageNav() as PreferredSizeWidget?,
      body: _bodyWidgets(),
      backgroundColor: Colors.white,
    );

  }

  /*
  * 构建导航栏
  * */
  Widget _pageNav() {

    return CupertinoNavbarIOS(
      middle: const Text(
        '登录',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
      ),
      leading: Offstage(
        offstage: (startPage ?? false),
        child: TapContainer(
          childWidget: NavBackButtonZH(
            LeftIconType.back,
          ),
          clickBlock: (){
            Get.back();
          },
        ),
      ),
    );

  }

  /*
  * 构建视图
  * */
  _bodyWidgets() {

    return Stack(
      children: [
        TapContainer(
          childWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 72.r,bottom: 25.r),
                  child: Image.asset(
                    "${SystemConfig.resource}logo.png",
                    width: 60.r,
                    height: 60.r,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  "成人技师按摩保健",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: const Color(0xFF1E1E1E),
                    decoration: TextDecoration.none,
                  ),
                ),
                PhoneEditView(
                  block: (int type ,String text){
                    _phoneEditClick(type,text);
                  },
                ),
                GetBuilder<UserLoginLogic>(
                  id: controller.countDownNotifyId,
                  builder: (controller){
                    return CodeEditView(
                      countDown: controller.countDown,
                      block: (int type,String value){
                        _codeEditViewClick(type,value);
                      },
                    );
                  },
                ),
                SizedBox(height: 48.r,),
                GetBuilder<UserLoginLogic>(
                  id: controller.buttonNotifyId,
                  builder: (controller){
                    return GoButton(
                      canClick: controller.buttonCanClick(),
                      block: (){
                        _loginClick();
                      },);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.r),
                  child: Text(
                    '未注册的手机号验证通过后将自动注册',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xFF6E6E6E)
                    ),
                  ),
                ),
                SizedBox(height: 150.r,),
                GetBuilder<UserLoginLogic>(
                  id: controller.checkedNotifyId,
                  builder: (controller){
                    return LoginBottomAlertWidget(
                      hasChecked: controller.hasChecked,
                      block: (int type){
                        _loginBottomAlertClick(type);
                      },
                    );
                  },
                )
              ],
            ),
          ),
          clickBlock: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        GetBuilder<UserLoginLogic>(
          id: controller.loadingNotifyId,
          builder: (controller){
            return Offstage(
              offstage: !(controller.isLoading),
              child: LoadingProgress(),
            );
          },
        ),
      ],
    );

  }

  /*
  * 登录标题点击
  *  type 1：勾选  2：用户协议  3：隐私政策
  * */
  _loginBottomAlertClick(int type){
    if(type == 1){
       controller.changeAgreementChecked();
    }
    else if(type == 2){
      _goAgreementPage(1);
    }
    else if(type == 3){
      _goAgreementPage(2);
    }
  }

  /*
  * 跳转到 用户协议 / 隐私政策
  * */
  _goAgreementPage(int type){
    print("==== t12 $type");
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
  * 电话编辑视图点击
  * type 1:切换区域  2：编辑手机号
  * */
  _phoneEditClick(int type ,String text){
    String phoneNum = text.replaceAll(' ', '');
    controller.changePhoneNumber(phoneNum);
  }

  /*
  * 电话编辑视图点击
  * type 1: 重新发送  2：输入验证码
  * */
  _codeEditViewClick(int type ,String text){
    if(type == 1){
      if(controller.phoneNumber.length >= 11){
        controller.requestLoginMessageCode();
      }
      else{
        showCupertinoDialog(
          context: context,
          builder: (BuildContext c) => AlertAppWidget(title: "请输入正确的手机号码", type: 1),
        );
      }
    }
    else if(type == 2){
      controller.changeCodeNumber(text);
    }
  }

  /*
  * 点击登录
  * */
  _loginClick(){
    FocusScope.of(context).requestFocus(FocusNode());
    if(_canLogin()){

      controller.requestLogin(
        success: (){
          RequestInterface.baseParams();

          if(startPage ?? false){
            Get.offAllNamed(Routers.main);
          }
          else{
            MainTabChangeTool.instance.changeToPhysioTab(500);
            Get.back();
          }
        },
        fail: (String msg){
          showCupertinoDialog(
            context: context,
            builder: (BuildContext c) => AlertAppWidget(title: msg, type: 1),
          );
        }
      );

    }
  }

  /*
  * 是否可以进入下一步
  * */
  bool _canLogin(){

    bool go = true;

    String alertTitle = '';
    if(controller.phoneNumber.length < 11){
      go = false;
      alertTitle = '请输入正确的手机号码';
    }
    else if(controller.codeNumber.isEmpty){
      go = false;
      alertTitle = '请输入短信验证码';
    }
    else if(controller.hasChecked != true){
      go = false;
      alertTitle = '请同意《用户协议》和《隐私政策》';
    }

    if(!go){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: alertTitle, type: 1),
      );
    }

    return go;

  }

  _autoPhoneLogin(){

    if(startPage ?? false){

      Future.delayed(const Duration(milliseconds: 300),(){
        ShanYanTool.instance.shanYanInit(
            startPage: startPage,
            successBlock: (){
              RequestInterface.baseParams();
              Future.delayed(const Duration(milliseconds: 300),(){
                Get.offAllNamed(Routers.main);
              });
            });
      });

    }

  }


}
