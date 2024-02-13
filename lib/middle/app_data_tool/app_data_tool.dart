import 'package:massage/business/all_service_users/model/request_waiter_tool.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';

import '../../business/home/models/BannerModel.dart';
import '../../business/home/models/Coupon.dart';
import '../../business/home/models/Main_data_response.dart';
import '../../business/home/models/Projects.dart';
import '../../business/home/models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class AppDataTool {

  static final AppDataTool _instance = AppDataTool();
  static AppDataTool get instance => _instance;

  List<BannerModel> banners = [];//广告栏
  List<ServiceUsers> serviceUsers = [];//所有技师列表
  List<Projects> projects = [];//所有项目列表
  List<Projects> cheapProjects = [];//特价项目列表
  List<ServiceUsers> nearbyServiceUsers = [];//附近技师列表
  List<ServiceUsers> recommendServiceUsers = [];//首页推荐技师列表
  List<Coupon> coupon =[];//优惠券列表

  initMyData(MainDataResponse response) async {

    banners = response.banners ?? [];//广告栏
    projects = response.projects ?? [];//所有项目列表
    coupon = response.coupon ?? [];//优惠券列表
    cheapProjects = [];//特价项目列表

    if((response.cheapProjects?.length ?? 0) > 0){
      for(int i = 0;i < response.cheapProjects!.length;i++){
        num pId = response.cheapProjects![i];
        for(int n = 0; n < projects.length;n++){
          Projects p = projects[n];
          if(pId == p.id){
            cheapProjects.add(p);
            break;
          }
        }
      }
    }
    serviceUsers = response.serviceUsers ?? [];//所有技师列表
    nearbyServiceUsers = [];//附近技师列表
    if((response.nearbyServiceUsers?.length ?? 0) > 0){
      for(int i = 0;i < response.nearbyServiceUsers!.length;i++){
        num uId = response.nearbyServiceUsers![i];
        for(int n = 0; n < serviceUsers.length;n++){
          ServiceUsers user = serviceUsers[n];
          if(uId == user.id){
            nearbyServiceUsers.add(user);
            break;
          }
        }
      }
    }

    recommendServiceUsers = [];//首页推荐技师列表
    if((response.recommendServiceUsers?.length ?? 0) > 0){
      for(int i = 0;i < response.recommendServiceUsers!.length;i++){
        num uId = response.recommendServiceUsers![i];
        for(int n = 0; n < serviceUsers.length;n++){
          ServiceUsers user = serviceUsers[n];
          if(uId == user.id){
            recommendServiceUsers.add(user);
            break;
          }
        }
      }
    }

    print("--f");
    if(UserDataLocalTool.instance.hasLogin){
      print("--f1");
      await refreshServiceUserList();
    }


  }

  /*
  * 刷新服务员列表 （根据黑名单列表刷新）
  * */
  refreshServiceUserList() async {
     if(serviceUsers.isNotEmpty){
       List<ServiceUsers> list = [];
       for(int i = 0;i < serviceUsers.length;i++){
         ServiceUsers serviceUser = serviceUsers[i];
         bool blacked =await RequestWaiterTool.instance.hasBlacked(serviceUser.id ?? 0);
         if(!blacked){
           list.add(serviceUser);
         }
       }
       serviceUsers = list;
     }
     if(nearbyServiceUsers.isNotEmpty){
       List<ServiceUsers> list = [];
       for(int i = 0;i < nearbyServiceUsers.length;i++){
         ServiceUsers serviceUser = nearbyServiceUsers[i];
         bool blacked =await RequestWaiterTool.instance.hasBlacked(serviceUser.id ?? 0);
         if(!blacked){
           list.add(serviceUser);
         }
       }
       nearbyServiceUsers = list;
     }
     if(recommendServiceUsers.isNotEmpty){
       List<ServiceUsers> list = [];
       for(int i = 0;i < recommendServiceUsers.length;i++){
         ServiceUsers serviceUser = recommendServiceUsers[i];
         bool blacked =await RequestWaiterTool.instance.hasBlacked(serviceUser.id ?? 0);
         if(!blacked){
           list.add(serviceUser);
         }
       }
       recommendServiceUsers = list;
     }
  }


}