
import 'package:get/get.dart';
import 'package:massage/business/all_service_users/model/request_waiter_tool.dart';
import 'package:massage/business/comment/model/request_tool_comments.dart';
import 'package:massage/business/coupon/model/coupon_request_tool.dart';
import 'package:massage/business/setting/model/exit_response.dart';
import 'package:massage/business/setting/model/logoff_alert_response.dart';
import 'package:massage/middle/network/request_interface.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';

import '../../../tools/util/network_manager_zh.dart';
import '../../order/model/request_tool_order.dart';
import '../model/logoff_response.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SettingLogic extends GetxController {

   bool networkLoading = false;

   final loadingNotifyId = 'loadingNotifyId';


   /*
  * 请求退出登录
  * */
   requestExit({required Function success,required Function fail}){

      networkLoading = true;

      update([loadingNotifyId]);

      RequestInterface.requestExit(key: UserDataLocalTool.instance.userInfo?.key).then((value) {

         NetworkManagerZH.instance.get(value).then((value) {

            if(value != null){

               ExitResponse response = ExitResponse.fromJson(value);

               if(response.code == 200){
                  UserDataLocalTool.instance.logout().then((value) {
                     success();
                  });

               }
               else{
                  fail();
               }
            }

            networkLoading = false;
            update([loadingNotifyId]);

         });

      });

   }

   /*
  * 请求注销账号提示文案
  * */
   requestLogoffAlert({required Function success,required Function fail}){

      networkLoading = true;

      update([loadingNotifyId]);

      RequestInterface.requestLogOffAlert(key: UserDataLocalTool.instance.userInfo?.key).then((value) {

         NetworkManagerZH.instance.get(value).then((value) {

            if(value != null){

               LogoffAlertResponse response = LogoffAlertResponse.fromJson(value);

               if(response.code == 200){
                  success(response.data?.tip ?? "");
               }
               else{
                  fail();
               }
            }

            networkLoading = false;
            update([loadingNotifyId]);

         });

      });

   }

   /*
  * 请求注销账号
  * */
   requestLogoff({required Function success,required Function fail}){

      networkLoading = true;

      update([loadingNotifyId]);

      RequestInterface.requestLogOff(key: UserDataLocalTool.instance.userInfo?.key).then((value) {

         NetworkManagerZH.instance.get(value).then((value) async {

            if(value != null){

               LogOffResponse response = LogOffResponse.fromJson(value);

               if(response.code == 200){

                  await RequestToolOrder.instance.clearOrderList();
                  await RequestToolComments.instance.clearCommentList();
                  await CouponRequestTool.instance.clearCouponList();
                  await RequestWaiterTool.instance.clearBlackList();
                  await RequestWaiterTool.instance.clearCareList();

                  UserDataLocalTool.instance.logoff().then((value) {
                     success();
                  });
               }
               else{
                  fail();
               }
            }

            networkLoading = false;
            update([loadingNotifyId]);

         });

      });

   }

}