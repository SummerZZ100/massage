
import 'package:app_store_score/app_store_score.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/login/login_util.dart';
import 'package:massage/business/main_tab/controller/main_tab_controller.dart';
import 'package:massage/business/main_tab/widgets/advert_widget.dart';
import 'package:massage/business/message/page/message_page.dart';
import 'package:massage/middle/network/request_interface.dart';
import 'package:massage/middle/talking_data_tool/talking_data_tool.dart';
import 'package:massage/tools/util/shared_preference_zh.dart';
import '../../../middle/ad_tool/app_config_tool.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/system_config.dart';
import '../../../middle/user_data_tool/user_data_local_tool.dart';
import '../../../middle/web_view/page/webview_zh_page.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../home/pages/a_home_page.dart';
import '../../mine/page/mine_page.dart';

///  主页面

class MainTabPage extends StatefulWidget {

  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();

}

class _MainTabPageState extends State<MainTabPage> {

  CupertinoTabController tabController = CupertinoTabController();

  late MainTabController controller;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(MainTabController());
    Future.delayed(const Duration(milliseconds: 300),(){
      _eventBusListener();
    });

    _showAdDialog();
    _appStoreScore();

    if(UserDataLocalTool.instance.hasLogin == true){
      _changeCurrentIndex();
    }
    else{
      tabController.index = currentIndex;
    }

    tabController.addListener(() {//tabbar监听
      /*
      * 判断登录状态
      * */
      if(tabController.index == 2 || tabController.index == 3){
        if(UserDataLocalTool.instance.hasLogin != true){
          tabController.index = currentIndex;
          LoginTool.goLogin();
        }
      }
      else if(tabController.index == 1 && AppConfigTool.instance.appConfigData?.lgo == '1'){
        if(UserDataLocalTool.instance.hasLogin != true){
          tabController.index = currentIndex;
          LoginTool.goLogin();
        }
      }

      currentIndex = tabController.index;

      TalkingDataTool.onEvent(currentIndex);

    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("main=== dispose");
    controller.dispose();
    _eventBusOff();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375,667),
        builder: (BuildContext context,Widget? child){
          return Scaffold(
            body: _buildMyWidget(),
            drawerEdgeDragWidth: 0.0,
          );
        });
  }

  _buildMyWidget(){
    return GetBuilder<MainTabController>(
      id: controller.tabStatus,
      builder: (controller){
        return CupertinoTabScaffold(
          controller: tabController,
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            activeColor: const Color(0xFF4985FD),
            inactiveColor: const Color(0xFF333333),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _tabIconWidget(title: '首页', selected: false),
                activeIcon: _tabIconWidget(title: '首页', selected: true),
                label: '首页',
              ),
              BottomNavigationBarItem(
                icon: _tabIconWidget(title: '理疗师', selected: false),
                activeIcon: _tabIconWidget(title: '理疗师', selected: true),
                label: '理疗师',
              ),
              BottomNavigationBarItem(
                icon: _tabIconWidget(title: '消息', selected: false),
                activeIcon: _tabIconWidget(title: '消息', selected: true),
                label: '消息',
              ),
              BottomNavigationBarItem(
                icon: _tabIconWidget(title: '我的', selected: false),
                activeIcon: _tabIconWidget(title: '我的', selected: true),
                label: '我的',
              ),
            ],
          ),
          tabBuilder: (BuildContext bc,int index){

            switch (index){
              case 0:
                return const AHomePage();
              case 1:
                {
                  return WebViewZHPage(
                    originalWebUrl: "",
                    title: '理疗师',
                    showLeftBtn: true,
                    inHomeTab: true,
                    share: false,
                    isSecondTab: true,
                  );
                }
              case 2:
                return WebViewZHPage(
                  originalWebUrl: AppConfigTool.instance.appConfigData?.chat_url ?? '',
                  title: '消息',
                  showLeftBtn: true,
                  inHomeTab: true,
                  share: false,
                );
              case 3:
                return const MinePage();
            }
            return Container();

          },
        );
      },
    );
  }

  _tabIconWidget({required String title,required bool selected}){

    if(selected == true){
      return Container(
        width: (ScreenUtil().screenWidth / 5) - 10.w,
        alignment: Alignment.center,
        padding:const EdgeInsets.only(top: 4),
        child: Image.asset(
          _tabLogoPath(title,selected),
          width: 20,
          height: 20,
        ),
      );
    }
    return Container(
      width: (ScreenUtil().screenWidth / 5) - 10.w,
      alignment: Alignment.center,
      padding:const EdgeInsets.only(top: 4),
      child: Image.asset(
        _tabLogoPath(title,selected),
          width: 20,
          height: 20,
      ),
    );

  }

  _changeCurrentIndex(){
    String tab = AppConfigTool.instance.appConfigData?.tab ?? '0';
    print("=== tab $tab");
    if(tab == '1'){
      currentIndex = 1;
      tabController.index = currentIndex;
    }

  }


  /*
  * 选中tab 图片地址
  * */
  _tabLogoPath(String title,bool selected) {

    String path = '${SystemConfig.resource}tab_home_n.png';
    if (title == '首页') {
      if(selected){
        path = '${SystemConfig.resource}tab_home_s.png';
      }
      else{
        path = '${SystemConfig.resource}tab_home_n.png';
      }

    }
    else if (title == '理疗师') {
      if(selected){
        path = '${SystemConfig.resource}tab_pt_s.png';
      }
      else{
        path = '${SystemConfig.resource}tab_pt_n.png';
      }
    }
    else if (title == '消息') {
      if(selected){
        path = '${SystemConfig.resource}tab_messsage_s.png';
      }
      else{
        path = '${SystemConfig.resource}tab_messsage_n.png';
      }
    }
    else if (title == '我的') {
      if(selected){
        path = '${SystemConfig.resource}tab_mine_s.png';
      }
      else{
        path = '${SystemConfig.resource}tab_mine_n.png';
      }
    }
    return path;
  }

  /*
  * appstore评分
  * */
  _appStoreScore() async {
    // AppConfigTool.instance.appConfigData?.rank = "1";
    String rank = AppConfigTool.instance.appConfigData?.rank ?? '0';
    if(rank == '1' && AppConfigTool.instance.hasShowAppStoreScore == false){
      AppConfigTool.instance.hasShowAppStoreScore = true;
      int startNumber = await SharedPreferenceZH.instance.obtainAppStartNumber();
      int milliseconds = 500;
      if(startNumber == 1){
        milliseconds = 5000;
      }
      Future.delayed(Duration(milliseconds: milliseconds),(){
        AppStoreScore().showAppStoreScore();
      });
    }

  }

  /*
  * 展示广告弹框
  * */
  _showAdDialog()async{

    if((AppConfigTool.instance.appConfigData?.box?.url?.length ?? 0) > 0){
      Future.delayed(const Duration(milliseconds: 500),(){
        showCupertinoDialog(
          context: context,
          builder: (BuildContext c) => AdvertWidget(advertBox: AppConfigTool.instance.appConfigData?.box!,),
        );
      });

    }

  }

  /*
  * eventbus监听
  * */
  _eventBusListener(){

    EventBusZH().on(EventBusNameZH.MainTabChangeToPhysioEventId, (arg) {
      if(mounted){
        print("========== mmmmm");
        tabController.index = 1;
        currentIndex = tabController.index;
      }
    });
    EventBusZH().on(EventBusNameZH.changeMainTab_ebn, (arg) {
      if(mounted){
        print("========== mmmmm1");
        _changeCurrentIndex();
      }
    });

  }

  _eventBusOff(){
    EventBusZH().off(EventBusNameZH.MainTabChangeToPhysioEventId);
    EventBusZH().off(EventBusNameZH.changeMainTab_ebn);
  }

}
