
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../model/Contact_address_model.dart';
import '../model/request_tool_contact_address.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AddressEditLogic extends GetxController {

   int row = 0;
   int editType = 0;// 0 新增  1:编辑

   late ContactAddressModel model;
   bool netLoading = false;

   final loadingNotifyId = 'loadingNotifyId';
   final caNotifyId = 'caNotifyId';
   final typeNotifyId = 'typeNotifyId';

   AddressEditLogic(Tuple2? tuple2){
      if(tuple2 != null){
         editType = 1;
         model = tuple2.item1;
         row = tuple2.item2;
      }
      else{
         model = ContactAddressModel(sex: '先生');
      }
   }

   changeAddress(String text){
      model.city = text;
   }

   changeDetailAddress(String text){
      model.addressDetail = text;
   }

   changeContactName(String text){
      model.contactName = text;
   }

   changeSex(String text){
      model.sex = text;
      update([caNotifyId]);
   }

   changePhone(String text){
      model.contactPhone = text;
   }

   changeType(int t){
      model.type = t;
      update([typeNotifyId]);
   }

   changeDefault(){
      model.isDefault = !(model.isDefault ?? false);
      update([typeNotifyId]);
   }

   requestCAM() async {
      netLoading = true;
      update([loadingNotifyId]);

      if(editType == 0){//新增
         await RequestToolContactAddress.instance.addContactAddress(model: model);
      }
      if(editType == 1){//编辑
         await RequestToolContactAddress.instance.modifyContactAddress(model: model, item: row);
      }
      netLoading = false;
      update([loadingNotifyId]);
   }

}