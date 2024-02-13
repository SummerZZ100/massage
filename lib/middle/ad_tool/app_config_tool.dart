import 'model/app_configure_response_data.dart';

///  create by zhangxiaosong on 2023/9/7
///  describtion 

class AppConfigTool {

  //工厂模式
  static final AppConfigTool _instance = AppConfigTool();
  static AppConfigTool get instance => _instance;

  AppConfigureResponseData? appConfigData;
  bool hasShowAppStoreScore = false;

}