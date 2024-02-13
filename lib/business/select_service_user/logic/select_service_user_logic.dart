
import 'package:get/get.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/middle/app_data_tool/app_data_tool.dart';
import '../../home/models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SelectServiceUsersLogic extends GetxController {

  Projects project;
  int serviceItem;
  int number;

  List<ServiceUsers> serviceUsers = [];
  final dataNotifyId = 'dataNotifyId';

  SelectServiceUsersLogic({required this.serviceItem,required this.project,required this.number});

  requestProjectServiceUsers() async {

    if(AppDataTool.instance.serviceUsers.isNotEmpty){

      for(int i = 0;i < AppDataTool.instance.serviceUsers.length;i++){
        ServiceUsers serviceUser = AppDataTool.instance.serviceUsers[i];
        if((serviceUser.projects?.length ?? 0) > 0){
          for (int j = 0;j < serviceUser.projects!.length;j++){
            Projects p = serviceUser.projects![j];
            if(p.id == project.id){
              serviceUsers.add(serviceUser);
              break;
            }
          }
        }
      }

    }

  }

}