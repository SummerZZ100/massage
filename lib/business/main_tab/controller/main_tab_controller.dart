
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///  create by zhangxiaosong on 2022/12/1
///  main tab 控制器



class MainTabController extends GetxController {

  final String tabStatus = 'tabStatus';//tab状态更新

  changeTabIndex(){
    update([tabStatus]);
  }


}

