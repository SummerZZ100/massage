import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/login/login_util.dart';
import 'package:massage/middle/ad_tool/app_config_tool.dart';
import 'package:massage/tools/util/shared_preference_zh.dart';
import 'package:get/get.dart';
import '../../../middle/ad_tool/model/app_configure_response.dart';
import '../../../middle/location_data_tool.dart';
import '../../../middle/network/request_interface.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/system_config.dart';
import '../../../middle/talking_data_tool/talking_data_tool.dart';
import '../../../middle/user_data_tool/user_data_local_tool.dart';
import '../../../middle/user_private_policy_alert.dart';
import '../../../tools/util/network_manager_zh.dart';
import '../../../tools/util/permission_zh.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

///  create by zhangxiaosong on 2023/9/3
///  启动页


class LaunchPage extends StatefulWidget {

  LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();

}

class _LaunchPageState extends State<LaunchPage> {

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int requestNumber = 0;
  bool hasRequest = false;

  @override
  void initState(){
    super.initState();

    _initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose(){
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeBottom: true,
        removeTop: true,
        context: context,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
            child: Image.asset(
              "${SystemConfig.resource}start_page.png",
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight - (ScreenUtil().statusBarHeight * 2),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status  $e');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print("con == $result");
    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
      if(!hasRequest){
        hasRequest = true;
        _requestNetWork();
      }

    }
  }

  _requestNetWork() async {
    await _requestAppConfigInfo();
    _requestLocation();

  }

  /*
  * 请求定位
  * */
  _requestLocation() async {
    PermissionStatusZH permissionStatus = await PermissionZH.instance.requestLocationPermission();

    if(permissionStatus == PermissionStatusZH.granted){
      LocationDataTool.instance.requestMyLocation();
      _showPrivacyAlert();
    }
    else{
      _showPrivacyAlert();
    }

  }

  /*
  * 展示隐私政策
  * */
  _showPrivacyAlert() async {

    bool offstageP = await SharedPreferenceZH.instance.obtainOffstagePrivacyPolicy();
    if(!offstageP){
      Future.delayed(const Duration(milliseconds: 500),(){
        showCupertinoDialog(
          context: context,
          builder: (BuildContext c) => UserPrivatePolicyAlert(
            block: () async{

              _jumpToMainPage();

            },
          ),
        );
      });
    }
    else {
      _jumpToMainPage();
    }

  }

  _jumpToMainPage() async {

    TalkingDataTool.initTalkingData();

    Future.delayed(const Duration(milliseconds: 200),(){
      if(AppConfigTool.instance.appConfigData?.prelogin == '1' && UserDataLocalTool.instance.hasLogin != true){
        LoginTool.firstGoLogin();
      }
      else{
        Get.offAllNamed(Routers.main);
      }
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
}

