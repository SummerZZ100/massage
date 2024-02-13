import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import 'package:get/get.dart';

import '../../../middle/router_manager.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../logic/near_service_users_logic.dart';
import '../widget/service_user_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class NearServiceUsersPage extends StatefulWidget {

  const NearServiceUsersPage({super.key});

  @override
  State<NearServiceUsersPage> createState() => _NearServiceUsersPageState();

}

class _NearServiceUsersPageState extends State<NearServiceUsersPage> {

  late NearServiceUsersLogic logic;

  @override
  void initState() {
    super.initState();

    List<ServiceUsers>? list = Get.arguments;
    logic = Get.put(NearServiceUsersLogic(nearbyServiceUsers: list ?? []));

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
        '找技师',
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

    return GetBuilder<NearServiceUsersLogic>(
      id: logic.dataNotifyId,
      builder: (control){
        return ListView.builder(
          itemBuilder: (BuildContext bc,int row){

            ServiceUsers serviceUser = logic.nearbyServiceUsers[row];
            return ServiceUserCell(serviceUser: serviceUser,
            block: (){
              Get.toNamed(Routers.service_user_detail,arguments: serviceUser)?.then((value){
                if(value != null && value > 0){
                   logic.deleteUser(value);
                }
              });
            },);
          },
          itemCount: logic.nearbyServiceUsers.length,
        );
      },
    );

  }
}
