
import 'package:get/get.dart';
import '../model/Contact_address_model.dart';
import '../model/request_tool_contact_address.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AddressListLogic extends GetxController {

   List<ContactAddressModel> list = [];
   bool netLoading = true;

   final dataNotifyId = 'dataNotifyId';
   final loadingNotifyId = 'loadingNotifyId';

   requestContactAddressList() async {
       list = await RequestToolContactAddress.instance.getContactAddressList();
       Future.delayed(const Duration(milliseconds: 500),(){
         netLoading = false;
         update([dataNotifyId,loadingNotifyId]);
       });

   }

   deleteCA(int item) async{
     netLoading = true;
     update([loadingNotifyId]);
     list = await RequestToolContactAddress.instance.deleteContactAddress(item: item);
     netLoading = false;
     update([dataNotifyId,loadingNotifyId]);
   }

   changeCADefault(int item) async {
     netLoading = true;
     update([loadingNotifyId]);
     ContactAddressModel model = list[item];
     model.isDefault = !(model.isDefault ?? false);
     list = await RequestToolContactAddress.instance.modifyContactAddress(model: model, item: item);
     netLoading = false;
     update([dataNotifyId,loadingNotifyId]);
   }





}