import 'package:get/get.dart';

import '../../../middle/app_data_tool/app_data_tool.dart';
import '../../../middle/network/request_interface.dart';
import '../../../tools/util/network_manager_zh.dart';
import '../../home/models/Coupon.dart';
import '../../home/models/Main_data_response.dart';
import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class MineLogic extends GetxController{

  List<Projects> cheapProjects = [];//特价项目列表
  List<Coupon> coupon =[];//优惠券列表

  final userNotifyId = 'userNotifyId';
  final dataNotifyId = 'dataNotifyId';

  refreshUserInfo(){
    update([userNotifyId]);
  }

  /*
  * 请求首页数据
  * */
  requestMainData({Function? success,Function? fail}){

    RequestInterface.requestMainData().then((urlLink){
      NetworkManagerZH.instance.get(urlLink).then((value) async{

        if(value != null){

          MainDataResponse response = MainDataResponse.fromJson(value);
          await _initMyData(response);
          if(success != null){
            success();
          }

        }
        else{
          if(fail != null){
            fail();
          }
        }

        update([dataNotifyId]);

      });
    });


  }

  _initMyData(MainDataResponse response) async {

    await AppDataTool.instance.initMyData(response);

    cheapProjects = AppDataTool.instance.cheapProjects;//特价项目列表
    coupon = AppDataTool.instance.coupon;//优惠券列表
  }

}