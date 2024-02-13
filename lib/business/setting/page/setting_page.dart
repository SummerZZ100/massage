import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/setting/logic/setting_logic.dart';
import 'package:massage/middle/ad_tool/app_config_tool.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/util/system_info_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../widget/setting_item_widget.dart';
import 'logoff_alert_widget.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SettingPage extends StatefulWidget {

  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();

}

class _SettingPageState extends State<SettingPage> {

  late SettingLogic logic;

  @override
  void initState() {
    super.initState();

    logic = Get.put(SettingLogic());

  }

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageNav() as PreferredSizeWidget?,
      body: _bodyWidgets(),
    );
  }

  /*
  * 构建导航栏
  * */
  Widget _pageNav() {

    return CupertinoNavbarIOS(
      middle: const Text(
        '设置',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
      ),
      leading: NavBackButtonZH(
        LeftIconType.back,
      ),
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Stack(
      children: [
        Column(
          children: [
            TapContainer(childWidget: const SettingItemWidget(),
              clickBlock: (){
                Get.toNamed(Routers.info_edit);
              },
            ),
            const Spacer(flex: 1,),
            TapContainer(
              childWidget: Container(
                width: ScreenUtil().screenWidth - 64.r,
                height: 48.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    color:const Color(0xFFBBBBBB)
                ),
                alignment: Alignment.center,
                child: Text(
                  "注销账号",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              clickBlock: (){
                _logOffAlert();
              },
            ),
            SizedBox(height: 22.r,),
            TapContainer(
              childWidget: Container(
                width: ScreenUtil().screenWidth - 64.r,
                height: 48.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    color: Colors.blueAccent
                ),
                alignment: Alignment.center,
                child: Text(
                  "退出登录",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              clickBlock: (){
                _exit();
              },
            ),
            Padding(padding: EdgeInsets.only(left: 10.r,top: 100.r,bottom: 10.r),
              child: FutureBuilder(
                future: SystemInfoZH.packageVersion(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return Text(
                      '版本：${snapshot.data ?? ''}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorValue.textColor3(),
                        fontSize: 14.sp,
                      ),
                    );
                  }
                  else{
                    return const SizedBox();
                  }
                },
              ),
            ),
            Text(
              '客服：${AppConfigTool.instance.appConfigData?.kefu ?? ''}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorValue.textColor3(),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 40.r,)
          ],
        ),
        GetBuilder<SettingLogic>(
          id: logic.loadingNotifyId,
          builder: (control){
            return Offstage(
              offstage: !(logic.networkLoading),
              child: LoadingProgress(),
            );
          },
        ),
      ],
    );

  }

  /*
  * 注销账号
  * */
  _logOffAlert(){

    logic.requestLogoffAlert(success: (String alert){
      String text = alert.replaceAll("\\n", "\n");
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => LogOffAlertWidget(title: text, type: 2,block: (int type){
          if(type == 2){
            _logOff();
          }
        },),
      );
    }, fail: (){

    });

  }

  _logOff(){
    logic.requestLogoff(success: (){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "当前账号已成功注销", type: 1,
          block: (int type){
            if(type == 2){
              _exitPage();
            }
          },),
      );
    }, fail: (){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "注销账号失败，请重新请求", type: 1),
      );
    });
  }

  /*
  * 退出登录
  * */
  _exit(){
    logic.requestExit(success: (){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "当前账号已成功退出登录", type: 1,
        block: (int type){
          if(type == 2){
            _exitPage();
          }
        },),
      );
    }, fail: (){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "退出登录失败，请重新请求", type: 1),
      );
    });
  }

  _exitPage(){
    Future.delayed(const Duration(milliseconds: 500),(){
      Get.offNamedUntil(Routers.main, (route) => false);
      // Get.offAllNamed(Routers.main);
    });

  }

}
