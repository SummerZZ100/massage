
import 'package:get/get.dart';
import '../../home/models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class NearServiceUsersLogic extends GetxController {

  List<ServiceUsers> nearbyServiceUsers = [];//附近技师列表
  final dataNotifyId = 'dataNotifyId';

  NearServiceUsersLogic({required this.nearbyServiceUsers});

  deleteUser(num userId){
    for(int i = 0;i < nearbyServiceUsers.length;i++){
      ServiceUsers serviceUser = nearbyServiceUsers[i];
      if(serviceUser.id == userId){
        nearbyServiceUsers.removeAt(i);
        break;
      }
    }
    update([dataNotifyId]);
  }

}