import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../middle/ad_tool/app_config_tool.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/web_view/page/webview_zh_page.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/tap_container.dart';
import '../../home/models/Projects.dart';
import '../../special_projects/widget/project_grid_item_view.dart';
import '../logic/mine_logic.dart';
import '../widget/mine_big_widget.dart';
import '../widget/mine_control_widget.dart';
import '../widget/mine_order_widget.dart';
import '../widget/uesr_info_widget.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class MinePage extends StatefulWidget {

  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();

}

class _MinePageState extends State<MinePage> {

  late MineLogic logic;

  @override
  void initState() {
    super.initState();
    logic = Get.put(MineLogic());
    logic.requestMainData();
    Future.delayed(const Duration(milliseconds: 600),(){
      _addEventBusListener();
    });

  }

  @override
  void dispose() {

    logic.dispose();
    _removeEventBusListener();
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
        '我的',
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

    return SingleChildScrollView(
      child: Column(
        children: [
          GetBuilder<MineLogic>(
            id: logic.userNotifyId,
            builder: (control){
              return UserInfoWidget(
                block: (int type){
                  _userInfoClick(type);
                },
              );
            },
          ),
          MineBigWidget(block: (int type){
            _orderClick(type);
          },),
          MineControlWidget(block: (int type) {
            _mineControlClick(type);
          },),
          Padding(
            padding: EdgeInsets.only(top: 10.r,bottom: 10.r),
            child: Text(
              '猜你喜欢',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: const Color(0xFF4985FD),
                decoration: TextDecoration.none,
              ),
            ),
          ),
          GetBuilder<MineLogic>(
            id: logic.dataNotifyId,
            builder: (control){
              return MasonryGridView.count(
                padding: EdgeInsets.only(left: 15.r,right: 15.r,top: 5.r),
                itemCount: logic.cheapProjects.length,
                crossAxisCount: 2,
                crossAxisSpacing: 15.r,
                mainAxisSpacing: 15.r,
                addAutomaticKeepAlives: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (bc,index){

                  Projects data = logic.cheapProjects[index];

                  return TapContainer(
                    childWidget: ProjectGridItemView(project: data,),
                    clickBlock: (){
                      _goDetail(data);
                    },
                  );

                },
              );
            },
          ),


        ],
      ),
    );

  }

  /*
  * type 1: 编辑信息  2:关注  3:粉丝
  * */
  _userInfoClick(int type){
    if(type == 1){
      Get.toNamed(Routers.info_edit);
    }
    else if(type == 2){
      // Get.toNamed(Routers.care);
    }
    else if(type == 3){
      // Get.toNamed(Routers.fans);
    }
  }

  /*
  * type 1:全部订单  2:待接单  3:待服务  4:已完成  5:退款/售后
  *
  * */
  _orderClick(int type){
    // int index = type - 1;
    // Get.toNamed(Routers.order_list,arguments: index);
    if(type == 1){//我的订单
      Get.to(() => WebViewZHPage(
        originalWebUrl: AppConfigTool.instance.appConfigData?.my_need_url ?? "",
        title: '我的订单',
        showLeftBtn: true,
        inHomeTab: false,
        share: false,
      ));
    }
    else if(type == 2){//我的钱包
      Get.to(() => WebViewZHPage(
        originalWebUrl: AppConfigTool.instance.appConfigData?.my_account ?? "",
        title: '我的钱包',
        showLeftBtn: true,
        inHomeTab: false,
        share: false,
      ));
    }
  }

  /*
  * type  1:优惠券  2:地址管理   3:我的评价   4:在线客服   5:隐私政策   6:设置
  * */
  _mineControlClick(int type){
    if(type == 1){
      Get.toNamed(Routers.coupon_list,arguments: logic.coupon);
    }
    else if(type == 2){
      Get.toNamed(Routers.address_list);
    }
    else if(type == 3){
      Get.toNamed(Routers.comment_list);
    }
    else if(type == 4){
      // Get.toNamed(Routers.chat_list,arguments: 2);
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: AppConfigTool.instance.appConfigData?.onlinekefu ?? "",
        title: '客服',
        showLeftBtn: true,
        inHomeTab: false,
      ));
    }
    else if(type == 5){
      Get.to(() =>  WebViewZHPage(
        originalWebUrl: 'https://imgs.ituiuu.cn/cdn/pages/privacy.html',
        title: '隐私政策',
        showLeftBtn: true,
        inHomeTab: false,
      ));
    }
    else if(type == 6){
      Get.toNamed(Routers.setting);
    }
  }

  _goDetail(Projects project){
    Get.toNamed(Routers.project_detail,arguments: project);
  }

  /*
  * eventbus监听
  * */
  _addEventBusListener(){

    EventBusZH().on(EventBusNameZH.RefreshMinePageEventId, (arg) {
      if(mounted){
         logic.refreshUserInfo();
      }
    });

  }

  _removeEventBusListener(){
    EventBusZH().off(EventBusNameZH.RefreshMinePageEventId);
  }



}
