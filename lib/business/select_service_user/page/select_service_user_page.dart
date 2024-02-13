import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import 'package:get/get.dart';
import 'package:massage/business/select_service_user/logic/select_service_user_logic.dart';
import 'package:massage/middle/router_manager.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../widget/select_service_user_cell.dart';
import 'package:tuple/tuple.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SelectServiceUsersPage extends StatefulWidget {

  const SelectServiceUsersPage({super.key});

  @override
  State<SelectServiceUsersPage> createState() => _SelectServiceUsersPageState();

}

class _SelectServiceUsersPageState extends State<SelectServiceUsersPage> {

  late SelectServiceUsersLogic logic;

  @override
  void initState() {
    super.initState();

    Tuple3 tuple3  = Get.arguments;

    logic = Get.put(SelectServiceUsersLogic(project: tuple3.item1,serviceItem: tuple3.item2,number: tuple3.item3));
    logic.requestProjectServiceUsers();

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
        '选择技师',
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

    return GetBuilder<SelectServiceUsersLogic>(
      id: logic.dataNotifyId,
      builder: (control){
        return ListView.builder(
          itemBuilder: (BuildContext bc,int row){
            ServiceUsers serviceUser = logic.serviceUsers[row];
            return SelectServiceUserCell(serviceUser: serviceUser,
            block: (){
              Get.toNamed(Routers.create_order,arguments: Tuple4(logic.project, serviceUser, logic.serviceItem, logic.number));
            },);
          },
          itemCount: logic.serviceUsers.length,
        );
      },
    );

  }
}
