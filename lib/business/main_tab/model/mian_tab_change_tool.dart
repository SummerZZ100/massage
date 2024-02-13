import '../../../middle/event_bus_name_zh.dart';
import '../../../tools/util/event_bus_zh.dart';

///  create by zhangxiaosong on 2023/10/11
///  describtion 

class MainTabChangeTool {

  static final MainTabChangeTool _instance = MainTabChangeTool();
  static MainTabChangeTool get instance => _instance;

  changeToPhysioTab(int milliseconds){
    Future.delayed(Duration(milliseconds: milliseconds),(){
      EventBusZH().emit(EventBusNameZH.MainTabChangeToPhysioEventId);
    });
  }

  changeDefaultTab(int milliseconds){
    Future.delayed(Duration(milliseconds: milliseconds),(){
      EventBusZH().emit(EventBusNameZH.changeMainTab_ebn);
    });
  }

}