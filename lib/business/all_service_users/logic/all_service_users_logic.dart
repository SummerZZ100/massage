
import 'package:get/get.dart';
import '../../all_projects/model/sort_model.dart';
import '../../home/models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AllServiceUsersLogic extends GetxController {

  List<ServiceUsers> allServiceUsers = [];//技师列表
  String searchText = '';

  List<SortModel> sortList = [];

  final dataNotifyId = 'dataNotifyId';
  final sortNotifyId = 'sortNotifyId';

  List<ServiceUsers> resultServiceUsers = [];//技师列表

  AllServiceUsersLogic({required this.allServiceUsers}){
    resultServiceUsers = [];
    resultServiceUsers.addAll(allServiceUsers);
    sortList = [SortModel(sortName: "综合排序",selected: true),
      SortModel(sortName: "距离排序",selected: false),
      SortModel(sortName: "接单量排序",selected: false),
    ];
  }

  deleteUser(num userId){
    for(int i = 0;i < allServiceUsers.length;i++){
      ServiceUsers serviceUser = allServiceUsers[i];
      if(serviceUser.id == userId){
        allServiceUsers.removeAt(i);
        break;
      }
    }

    resultServiceUsers = [];
    for(int i = 0;i < allServiceUsers.length;i++){
      ServiceUsers serviceUser = allServiceUsers[i];
      if((serviceUser.nickname?.length ?? 0) > 0){
        if(serviceUser.nickname!.contains(searchText)){
          resultServiceUsers.add(serviceUser);
        }
      }
    }

    update([dataNotifyId]);
  }

  changeSearchText(String text){
    searchText = text;
  }

  changeCommitSearch(){
    String sortName = currentSort();
    changeSort(sortName);
  }

  _refreshResults(){
    resultServiceUsers = [];
    for(int i = 0;i < allServiceUsers.length;i++){
      ServiceUsers serviceUser = allServiceUsers[i];
      if((serviceUser.nickname?.length ?? 0) > 0){
        if(serviceUser.nickname!.contains(searchText)){
          resultServiceUsers.add(serviceUser);
        }
      }
    }
  }

  String currentSort(){
    String sort = '综合排序';
    for(int i = 0;i < sortList.length;i++){
      SortModel sortModel = sortList[i];
      if(sortModel.selected == true){
        sort = sortModel.sortName ?? '';
        break;
      }
    }
    return sort;
  }

  changeSort(String sortName){
    for(int i = 0;i < sortList.length;i++){
      SortModel sortModel = sortList[i];
      if(sortName == sortModel.sortName){
        sortModel.selected = true;
      }
      else{
        sortModel.selected = false;
      }
    }
    update([sortNotifyId]);

    if(sortName == '综合排序'){
      _refreshResults();
      update([dataNotifyId]);
    }
    else if(sortName == '距离排序'){
      _refreshResults();
      for(int i = 0;i < resultServiceUsers.length - 1;i++){
        ServiceUsers serviceUser = resultServiceUsers[i];
        for(int j = i+1;j < resultServiceUsers.length;j++){
          ServiceUsers s = resultServiceUsers[j];
          if((s.distance ?? 0) < (serviceUser.distance ?? 0)){
            ServiceUsers temp = ServiceUsers.fromJson(s.toJson());
            resultServiceUsers[j] = ServiceUsers.fromJson(resultServiceUsers[i].toJson());
            resultServiceUsers[i] = temp;
            serviceUser = resultServiceUsers[i];
          }
        }
      }
      update([dataNotifyId]);
    }
    else if(sortName == '接单量排序'){
      _refreshResults();
      for(int i = 0;i < resultServiceUsers.length - 1;i++){
        ServiceUsers serviceUser = resultServiceUsers[i];
        for(int j = i+1;j < resultServiceUsers.length;j++){
          ServiceUsers s = resultServiceUsers[j];
          if((s.orderNum ?? 0) > (serviceUser.orderNum ?? 0)){
            ServiceUsers temp = ServiceUsers.fromJson(s.toJson());
            resultServiceUsers[j] = ServiceUsers.fromJson(resultServiceUsers[i].toJson());
            resultServiceUsers[i] = temp;
            serviceUser = resultServiceUsers[i];
          }
        }
      }
      update([dataNotifyId]);
    }

  }

}