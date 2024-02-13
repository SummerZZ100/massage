
import 'package:get/get.dart';
import 'package:massage/business/all_projects/model/sort_model.dart';
import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AllProjectsLogic extends GetxController {

  List<Projects> projects = [];//所有项目列表
  String searchText = '';
  List<Projects> resultProjects = [];//搜索到的项目列表

  List<SortModel> sortList = [];

  final dataNotifyId = 'dataNotifyId';
  final sortNotifyId = 'sortNotifyId';

  AllProjectsLogic({required this.projects}){
    resultProjects = [];
    resultProjects.addAll(projects);
    sortList = [SortModel(sortName: "综合排序",selected: true),
      SortModel(sortName: "价格排序",selected: false),
      SortModel(sortName: "时长排序",selected: false),
    ];
  }


  changeSearchText(String text){
    searchText = text;
  }

  changeCommitSearch(){

    String sortName = currentSort();
    changeSort(sortName);

  }

  _refreshResults(){
    resultProjects = [];
    for(int i = 0;i < projects.length;i++){
      Projects project = projects[i];
      if((project.name?.length ?? 0) > 0){
        if(project.name!.contains(searchText)){
          resultProjects.add(project);
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
    else if(sortName == '价格排序'){
      _refreshResults();
      for(int i = 0;i < resultProjects.length - 1;i++){
        Projects project = resultProjects[i];
        for(int j = i+1;j < resultProjects.length;j++){
          Projects p = resultProjects[j];
          if((p.price ?? 0) > (project.price ?? 0)){
            Projects temp = Projects.fromJson(p.toJson());
            resultProjects[j] = Projects.fromJson(resultProjects[i].toJson());
            resultProjects[i] = temp;
            project = resultProjects[i];
          }
        }
      }
      update([dataNotifyId]);
    }
    else if(sortName == '时长排序'){
      _refreshResults();
      for(int i = 0;i < resultProjects.length - 1;i++){
        Projects project = resultProjects[i];
        for(int j = i+1;j < resultProjects.length;j++){
          Projects p = resultProjects[j];
          if((p.time ?? 0) > (project.time ?? 0)){
            Projects temp = Projects.fromJson(p.toJson());
            resultProjects[j] = Projects.fromJson(resultProjects[i].toJson());
            resultProjects[i] = temp;
            project = resultProjects[i];
          }
        }
      }
      update([dataNotifyId]);
    }

  }

}