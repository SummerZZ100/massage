import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:massage/business/special_projects/logic/special_projects_logic.dart';
import 'package:get/get.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/router_manager.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../home/models/Projects.dart';
import '../widget/project_grid_item_view.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SpecialProjectsPage extends StatefulWidget {

  const SpecialProjectsPage({super.key});

  @override
  State<SpecialProjectsPage> createState() => _SpecialProjectsPageState();

}

class _SpecialProjectsPageState extends State<SpecialProjectsPage> {

  late SpecialProjectsLogic logic;

  @override
  void initState() {
    super.initState();

    List<Projects>? list = Get.arguments;
    logic = Get.put(SpecialProjectsLogic(cheapProjects: list ?? []));

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
        '找服务',
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

    return GetBuilder<SpecialProjectsLogic>(
      id: logic.dataNotifyId,
      builder: (control){
        return MasonryGridView.count(
          padding: EdgeInsets.only(left: 15.r,right: 15.r,top: 5.r),
          itemCount: logic.cheapProjects.length,
          crossAxisCount: 2,
          crossAxisSpacing: 15.r,
          mainAxisSpacing: 15.r,
          addAutomaticKeepAlives: false,
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
    );

  }

  _goDetail(Projects project){
    Get.toNamed(Routers.project_detail,arguments: project);
  }

}
