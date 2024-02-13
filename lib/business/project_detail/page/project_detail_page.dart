import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/business/main_tab/model/mian_tab_change_tool.dart';
import 'package:massage/business/project_detail/logic/project_detail_logic.dart';
import 'package:massage/business/project_detail/page/project_select_widget.dart';
import 'package:massage/middle/ad_tool/app_config_tool.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:tuple/tuple.dart';

import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/network/request_interface.dart';
import '../../../middle/user_data_tool/user_data_local_tool.dart';
import '../../../middle/web_view/page/webview_zh_page.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../login/login_util.dart';
import '../widget/project_comment_widget.dart';
import '../widget/project_des_widget.dart';
import '../widget/project_detail_banner.dart';
import '../widget/project_detail_bottom.dart';
import '../widget/project_title_widget.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class ProjectDetailPage extends StatefulWidget {

  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {

  late ProjectDetailLogic logic;

  @override
  void initState() {
    super.initState();

    Projects project = Get.arguments;
    logic = Get.put(ProjectDetailLogic(project: project));

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
      middle: Text(
        logic.project.name ?? '',
        style: const TextStyle(
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

    return GetBuilder<ProjectDetailLogic>(
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
                    ProjectDetailBanner(banners: logic.project.imgSrc ?? [],),
                    ProjectTitleWidget(project: logic.project,),
                    ProjectDesWidget(project: logic.project,),
                    SizedBox(height: 10.r,),
                    ProjectCommentWidget(project: logic.project,),
                  ],
                ),
              ),
            ),
            ProjectDetailBottom(project: logic.project,block: (){
              _bookClick();
            },),

          ],
        );
      },
    );

  }

  _bookClick(){

    if(UserDataLocalTool.instance.hasLogin != true){
      LoginTool.goLogin();
      return;
    }

    // AppConfigTool.instance.appConfigData?.full = '';
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
          return ProjectSelectWidget(project: logic.project, block: (int serviceItem,int num){
            Future.delayed(const Duration(milliseconds: 500),(){
              Get.toNamed(Routers.select_service_user,arguments: Tuple3(logic.project, serviceItem, num));
            });
          });
        },
      );
    }

  }

}
