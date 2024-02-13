import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/logic/a_home_logic.dart';
import 'package:get/get.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/business/home/widgets/home_banner.dart';
import 'package:massage/business/login/login_util.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:massage/tools/widgets/cupertino_dialog_tool.dart';
import 'package:massage/tools/widgets/cupertino_navbar_ios.dart';
import 'package:massage/tools/widgets/loading_progress.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/web_view/page/webview_zh_page.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../models/BannerModel.dart';
import '../models/ServiceUsers.dart';
import '../widgets/check_more_title.dart';
import '../widgets/home_location_title_alert.dart';
import '../widgets/home_recommend_su_cell.dart';
import '../widgets/home_top_search_widget.dart';
import '../widgets/product_info_cell.dart';
import '../widgets/special_home_cell.dart';
import 'package:open_app_settings/open_app_settings.dart';


///  create by zhangxiaosong on 2023/9/6
///  describtion 

class AHomePage extends StatefulWidget {

  const AHomePage({super.key});

  @override
  State<AHomePage> createState() => _AHomePageState();

}

class _AHomePageState extends State<AHomePage> {

  late AHomeLogic logic;

  @override
  void initState() {
    super.initState();
    logic = Get.put(AHomeLogic());
    _requestMainData(false,true);

    Future.delayed(const Duration(milliseconds: 600),(){
      _eventBusListener();
    });

  }

  @override
  void dispose() {

    _eventBusOff();
    logic.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeNav() as PreferredSizeWidget?,
      body: _bodyWidgets(),
      // backgroundColor: Colors.white,
    );

  }

  /*
  * 构建导航栏
  * */
  Widget _homeNav() {

    return const CupertinoNavbarIOS(
      middle: Text(
        '首页',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
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
            GetBuilder<AHomeLogic>(
              id: logic.locationNotifyId,
              builder: (control){
                return HomeTopSearchWidget(city: logic.city,
                block: (){
                  if(UserDataLocalTool.instance.hasLogin != true){
                    LoginTool.goLogin();
                    return;
                  }
                   Get.toNamed(Routers.search_page);
                },);
              },
            ),
            Expanded(child: GetBuilder<AHomeLogic>(
              id: logic.dataNotifyId,
              builder: (control){
                return ListView.builder(
                  itemBuilder: (BuildContext bc,int row){

                    if(row == 0){
                      if(logic.banners.isNotEmpty){//banner
                        return HomeBanner(banners: logic.banners,
                          block: (BannerModel banner){
                            _bannerClick(banner);
                          },);
                      }
                      else{
                        return const SizedBox();
                      }
                    }
                    else if(row == 1){
                      if(logic.cheapProjects.isNotEmpty || logic.nearbyServiceUsers.isNotEmpty || logic.coupon.isNotEmpty){
                        return SpecialHomeCell(block: (int type){
                          _specialWidgetClick(type);
                        },);
                      }
                      else{
                        return const SizedBox();
                      }
                    }
                    else if(row == 2){
                      if(logic.recommendServiceUsers.isNotEmpty){
                        return HomeRecommendSUCell(
                          recommendServiceUsers: logic.recommendServiceUsers,
                          block: _recommendServiceUsersClick,
                        );
                      }
                      else{
                        return const SizedBox();
                      }
                    }
                    else if(row == 3){
                      if(logic.projects.isNotEmpty){
                        return TapContainer(childWidget: const CheckMoreTitle(),clickBlock: (){
                          _moreProjects();
                        },);
                      }
                      else{
                        return const SizedBox();
                      }
                    }
                    else if(row >= 4){
                      if(logic.projects.isNotEmpty){
                        int item = row - 4;
                        return ProductInfoCell(project: logic.projects[item],
                          block: (){
                            Projects p = logic.projects[item];
                            _bookProject(p);
                          },);
                      }
                      else{
                        return const SizedBox();
                      }
                    }

                    return const SizedBox();

                  },
                  itemCount: (logic.projects.length + 4),
                );
              },
            ))
          ],
        ),
        Positioned(
          left: 0,
          top: 40.r,
          child: GetBuilder<AHomeLogic>(
            id: logic.locationNotifyId,
            builder: (control){
              return Offstage(
                offstage: (logic.hasLocation),
                child: HomeLocationTitleAlert(
                  block: (){
                    _goLocationSetting();
                  },
                ),
              );
            },
          ),
        ),
        GetBuilder<AHomeLogic>(
          id: logic.loadingNotifyId,
          builder: (control){
            return Offstage(
              offstage: !(logic.netLoading),
              child: LoadingProgress(),
            );
          },
        ),
      ],
    );

  }

  _requestMainData(bool notify,bool location) async {

    if(location){

      Future.delayed(const Duration(milliseconds: 800),(){
        logic.requestLocation();
      });

    }

    logic.requestMainData(
        notify: notify,
        success: (){},
        fail: (){}
    );

  }

  _goLocationSetting(){
    CupertinoDialogTool.instance!.showAlertDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(
          '请在设置->隐私->定位服务中开启定位服务，以获取位置信息',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              '取消',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                // fontFamily: CCMFont.PingFang,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(
              '去设置',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                // fontFamily: CCMFont.PingFang,
              ),
            ),
            onPressed: () async{
              logic.changeLocationTrue();
              Navigator.of(context).pop();
              OpenAppSettings.openAppSettings();
            },
          )
        ],
      ),
    );
  }

  _bannerClick(BannerModel bannerModel){

    // if(UserDataLocalTool.instance.hasLogin != true){
    //   LoginTool.goLogin();
    //   return;
    // }

    if((bannerModel.linkUrl?.length ?? 0) > 0){
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: bannerModel.linkUrl!,//
        title: '',
        showLeftBtn: true,
        inHomeTab: false,
      ));
    }
  }


  _specialWidgetClick(int type){

    // if(UserDataLocalTool.instance.hasLogin != true){
    //   LoginTool.goLogin();
    //   return;
    // }

    if(type == 1){//特价项目
       Get.toNamed(Routers.special_projects,arguments: logic.cheapProjects);
    }
    else if(type == 2){//附近技师
      if(logic.hasLocation){
        Get.toNamed(Routers.near_service_users,arguments: logic.nearbyServiceUsers);
      }
      else{
        _goLocationSetting();
      }
    }
    else if(type == 3){//优惠券
      Get.toNamed(Routers.coupon_list,arguments: logic.coupon);
    }
  }

  _recommendServiceUsersClick(int type,ServiceUsers? u){

    // if(UserDataLocalTool.instance.hasLogin != true){
    //   LoginTool.goLogin();
    //   return;
    // }

    if(type == 1){//更多技师
      Get.toNamed(Routers.all_service_users,arguments: logic.serviceUsers);
    }
    else if(type == 2){//点击单个技师
      if(u != null){
         Get.toNamed(Routers.service_user_detail,arguments: u);
      }
    }
  }

  _moreProjects(){
    // if(UserDataLocalTool.instance.hasLogin != true){
    //   LoginTool.goLogin();
    //   return;
    // }

    Get.toNamed(Routers.all_projects,arguments: logic.projects);

  }

  _bookProject(Projects p){
    if(UserDataLocalTool.instance.hasLogin != true){
      LoginTool.goLogin();
      return;
    }

    Get.toNamed(Routers.project_detail,arguments: p);

  }

  /*
  * eventbus监听
  * */
  _eventBusListener(){
    EventBusZH().on(EventBusNameZH.RefreshHomePageEventId, (arg) {
      if(mounted){
        _requestMainData(false, true);
      }
    });
    EventBusZH().on(EventBusNameZH.RefreshHomeBlackEventId, (arg) {
      if(mounted){
        _requestMainData(false, false);
      }
    });

  }

  _eventBusOff(){
    EventBusZH().off(EventBusNameZH.RefreshHomePageEventId);
    EventBusZH().off(EventBusNameZH.RefreshHomeBlackEventId);
  }


}
