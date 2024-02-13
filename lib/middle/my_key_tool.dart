import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';

///  create by zhangxiaosong on 2023/9/16
///  describtion 

class MyKeyTool {

  static final MyKeyTool _instance = MyKeyTool();
  static MyKeyTool get instance => _instance;

  Future<bool> isMyKey() async {//1540234554739240363635683
    String userKey = await UserDataLocalTool.instance.getUserKey();
    if(userKey == '1540234554739240363635683' || userKey == '12803910439234140'){
      return true;
    }
    return false;
  }

}