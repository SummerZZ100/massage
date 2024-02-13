
import 'package:get/get.dart';

import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/user_data_tool/user_data_local_tool.dart';
import '../../../tools/util/event_bus_zh.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class InfoEditLogic extends GetxController {

   bool netLoading = false;

   final dataNotifyId = 'dataNotifyId';
   final headerNotifyId = 'headerNotifyId';
   final loadingNotifyId = 'loadingNotifyId';

   changePhoto(List<int> photo) async {

      netLoading = true;
      update([loadingNotifyId]);
      await UserDataLocalTool.instance.changeHeader(photo);

      EventBusZH().emit(EventBusNameZH.RefreshMinePageEventId);

      netLoading = false;
      update([loadingNotifyId,headerNotifyId]);
   }

   changeSex(int sex) async {

      netLoading = true;
      update([loadingNotifyId]);
      await UserDataLocalTool.instance.changeGender('$sex');

      netLoading = false;
      update([loadingNotifyId,dataNotifyId]);
   }

   changeBirthday(DateTime dateTime) async {
      netLoading = true;
      update([loadingNotifyId]);
      await UserDataLocalTool.instance.changeAge('$dateTime');

      netLoading = false;
      update([loadingNotifyId,dataNotifyId]);
   }



   refreshMyInfo(){
      update([dataNotifyId]);
   }

}