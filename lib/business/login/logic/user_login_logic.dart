/**
 *  登录-控制器
 */

import 'dart:async';

import 'package:get/get.dart';
import 'package:massage/business/login/model/LoginResponse.dart';
import 'package:massage/middle/network/request_interface.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';

import '../../../middle/ad_tool/app_config_tool.dart';
import '../../../middle/ad_tool/model/app_configure_response.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/util/network_manager_zh.dart';
import '../../order/model/request_tool_order.dart';
import '../model/LoginMessageCodeResponse.dart';



/*
* 登录
* */
class UserLoginLogic extends GetxController {

  bool hasChecked = true;//是否已经勾选同意
  String phoneNumber = '';
  String codeNumber = '';
  bool isLoading = false;//是否处于网络加载中
  String? clock;

  Timer? timer;
  int countDown = 0;//倒计时

  final checkedNotifyId = 'checkedNotifyId';//标题是否勾选同意状态
  final buttonNotifyId = 'buttonNotifyId';//登录按钮状态
  final loadingNotifyId = 'loadingNotifyId';//网络加载状态
  final countDownNotifyId = 'countDownNotifyId';

  @override
  void dispose() {

    _stopTimer();

    super.dispose();
  }

  /*
  * 改变勾选状态
  * */
  changeAgreementChecked(){
    hasChecked = !hasChecked;
    update([checkedNotifyId]);
  }

  /*
  * 改变录入的手机号
  * */
  changePhoneNumber(String number){
    phoneNumber = number;
    update([buttonNotifyId]);
  }

  /*
  * 改变录入的验证码
  * */
  changeCodeNumber(String number){
    codeNumber = number;
  }


  /*
  * 按钮是否可点击
  * */
  bool buttonCanClick(){
    if(phoneNumber.length >= 11){
      return true;
    }
    return false;
  }

  /*
  * 请求登录
  * */
  requestLogin({Function? success,Function? fail}){

    isLoading = true;
    update([loadingNotifyId]);

    RequestInterface.requestLogin(phone: phoneNumber,code: codeNumber).then((value) {

      NetworkManagerZH.instance.post(value).then((value){

        if(value != null){

          LoginResponse response = LoginResponse.fromJson(value);
          if(response.code == 200 && response.data != null){
            UserDataLocalTool.instance.login(
              data: response.data!,
            ).then((value) async {

              await RequestToolOrder.instance.defaultUserOrderList();
              await _requestAppConfigInfo();

              EventBusZH().emit(EventBusNameZH.RefreshHomePageEventId);
              EventBusZH().emit(EventBusNameZH.RefreshPhysioPageEventId);
              EventBusZH().emit(EventBusNameZH.RefreshMessagePageEventId);
              EventBusZH().emit(EventBusNameZH.RefreshMinePageEventId);

              if(success != null) {
                success();
              }

            });

          }
          else{
            if(fail != null){
              fail(response.msg ?? "验证失败，请重新验证");
            }
          }
        }

        isLoading = false;
        update([loadingNotifyId]);

      });

    });

  }

  /*
  *  请求app配置信息
  * */
  _requestAppConfigInfo() async {

    String settingUrl = await RequestInterface.requestSettingConfig(token: UserDataLocalTool.instance.userInfo?.key);

    var value = await NetworkManagerZH.instance.get(settingUrl);
    if(value != null){
      AppConfigureResponse res = AppConfigureResponse.fromJson(value);
      if(res.code == 200){
        AppConfigTool.instance.appConfigData = res.configData;
      }
    }

  }


  /*
  * 请求手机短信二维码
  * */
  requestLoginMessageCode(){

    isLoading = true;
    update([loadingNotifyId]);

    RequestInterface.requestLoginMessageCode(phone: phoneNumber).then((value) {

      NetworkManagerZH.instance.post(value).then((value) {

        if(value != null){
          LoginMessageCodeResponse response = LoginMessageCodeResponse.fromJson(value);
          if(response.code == 200){
            _resetCountDown();
          }
        }

        isLoading = false;
        update([loadingNotifyId]);

      });

    });
  }

  /*
  * 重制倒计时
  * */
  _resetCountDown(){
    countDown = 60;
    _startTimer();
  }


  /*
  * 开始倒计时
  * */
  _startTimer(){

    _stopTimer();

    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(oneSec, (timer){

      countDown -= 1;
      update([countDownNotifyId]);
      if(countDown <= 0){
        timer.cancel();
      }

    });

  }

  /*
  * 结束倒计时
  * */
  _stopTimer(){
    if(timer != null){
      timer!.cancel();
      timer = null;
    }
  }


}