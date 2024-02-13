import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/all_service_users/model/request_waiter_tool.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import 'package:massage/business/service_user_detail/page/service_user_more_widget.dart';
import 'package:tuple/tuple.dart';
import '../../../middle/ad_tool/app_config_tool.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/network/request_interface.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/user_data_tool/user_data_local_tool.dart';
import '../../../middle/web_view/page/webview_zh_page.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../../../tools/widgets/tap_container.dart';
import '../../login/login_util.dart';
import '../../main_tab/model/mian_tab_change_tool.dart';
import '../../project_detail/page/project_select_widget.dart';
import '../logic/service_user_detail_logic.dart';
import '../widget/service_d_content_widget.dart';
import '../widget/service_user_comment_widget.dart';
import '../widget/service_user_d_title_widget.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class ServiceUserDetailPage extends StatefulWidget {

  const ServiceUserDetailPage({super.key});

  @override
  State<ServiceUserDetailPage> createState() => _ServiceUserDetailPagePageState();
}

class _ServiceUserDetailPagePageState extends State<ServiceUserDetailPage> {

  late ServiceUserDetailLogic logic;

  @override
  void initState() {
    super.initState();

    ServiceUsers serviceUser = Get.arguments;
    logic = Get.put(ServiceUserDetailLogic(serviceUser: serviceUser));

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
      middle:const Text(
        '技师详情',
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
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TapContainer(
            childWidget: Container(
              width: 60,
              height: 24,
              decoration:const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.blueAccent
              ),
              alignment: Alignment.center,
              child:const Text(
                "+关注",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            clickBlock: (){
              _careClick();
            },
          ),
          TapContainer(
            childWidget:const Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
              child: Icon(
                Icons.more_horiz,
                color: Color(0xFF333333),
                size: 24,
              ),
            ),
            clickBlock: (){
              _moreClick();
            },
          ),

        ],
      ),
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return GetBuilder<ServiceUserDetailLogic>(
      id: logic.dataNotifyId,
      builder: (control){
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageWidgetZH(
                      imageUrl: logic.serviceUser.headSrc,
                      imageWidth: ScreenUtil().screenWidth,
                      imageHeight: 200.r,
                      style: 1,
                      fit:BoxFit.contain,
                    ),
                    ServiceUserDTitleWidget(serviceUser: logic.serviceUser,),
                    ServiceDContentWidget(serviceUser: logic.serviceUser,
                    block: (Projects p){
                      _bookClick(p);
                    },),
                    SizedBox(height: 10.r,),
                    ServiceUserCommentWidget(serviceUser: logic.serviceUser,),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

  }

  _bookClick(Projects p){

    if(UserDataLocalTool.instance.hasLogin != true){
      LoginTool.goLogin();
      return;
    }

    if((AppConfigTool.instance.appConfigData?.full?.length ?? 0) > 0){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: AppConfigTool.instance.appConfigData?.full ?? "", type: 2,block: (int type){
          if(type == 2){
            // Get.to(() => WebViewZHPage(
            //   originalWebUrl: RequestInterface.myH5Url(),
            //   title: '理疗师',
            //   showLeftBtn: true,
            //   inHomeTab: false,
            //   share: false,
            // ));
            MainTabChangeTool.instance.changeToPhysioTab(500);
            Get.offNamedUntil(Routers.main, (route) => false);
          }
        },),
      );
    }
    else{
      showModalBottomSheet<int>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
        ),
        builder: (BuildContext bc) {
          return ProjectSelectWidget(project: p, block: (int serviceItem,int num){
            Future.delayed(const Duration(milliseconds: 500),(){
              Get.toNamed(Routers.create_order,arguments: Tuple4(p, logic.serviceUser, serviceItem, num));
            });
          });
        },
      );
    }

  }

  _careClick() async {

    if(UserDataLocalTool.instance.hasLogin != true){
      LoginTool.goLogin();
      return;
    }

    bool cared = await RequestWaiterTool.instance.hasCared(logic.serviceUser.id ?? 0);
    if(cared){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "您已关注过该技师", type: 1,block: (int type){
        },),
      );
    }
    else{
      await RequestWaiterTool.instance.addCare(careId: logic.serviceUser.id ?? 0);
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "成功添加关注", type: 1,block: (int type){
        },),
      );
    }

  }

  _moreClick(){

    if(UserDataLocalTool.instance.hasLogin != true){
      LoginTool.goLogin();
      return;
    }

    showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r), topRight: Radius.circular(4.r)),
      ),
      builder: (BuildContext bc) {
        return ServiceUserMoreWidget(block: (int type){
          _moreViewClick(type);
        },);
      },
    );
  }

  _moreViewClick(int type) async {
    if(type == 1){//拉黑
      await Future.delayed(const Duration(milliseconds: 300));
      bool blacked = await RequestWaiterTool.instance.hasBlacked(logic.serviceUser.id ?? 0);
      if(blacked){
        showCupertinoDialog(
          context: context,
          builder: (BuildContext c) => AlertAppWidget(title: "当前服务员已在黑名单中", type: 1,block: (int type){
          },),
        );
      }
      else{
        await RequestWaiterTool.instance.addBlack(blackId: logic.serviceUser.id ?? 0);
        showCupertinoDialog(
          context: context,
          builder: (BuildContext c) => AlertAppWidget(title: "已将当前服务员加入黑名单", type: 1,block: (int type){
            _blackSuccess();
          },),
        );
      }
    }
    else if(type == 2){//举报
       Future.delayed(const Duration(milliseconds: 300),(){
          Get.toNamed(Routers.report_content_list);
       });
    }
  }

  _blackSuccess(){

    print("----fe1");
    EventBusZH().emit(EventBusNameZH.RefreshHomeBlackEventId);

    Future.delayed(const Duration(milliseconds: 300),(){
      Get.back(result: logic.serviceUser.id ?? 0);
    });
  }

}
