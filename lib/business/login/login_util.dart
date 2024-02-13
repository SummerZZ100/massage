import 'package:get/get.dart';
import 'package:massage/middle/shanyan_tool/shanyan_tool.dart';

import '../../middle/router_manager.dart';


class LoginTool {

  static goLogin(){

    ShanYanTool.instance.shanYanInit(
    otherLoginBlock: (){
      Get.toNamed(Routers.login_page,arguments: false)?.then((value) {
      });
    });

  }

  static firstGoLogin(){

    Get.toNamed(Routers.login_page,arguments: true)?.then((value) {

    });

  }

}