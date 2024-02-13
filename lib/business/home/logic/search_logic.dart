import 'package:get/get.dart';

import '../../../middle/app_data_tool/app_data_tool.dart';
import '../models/Projects.dart';
import '../models/ServiceUsers.dart';
import '../models/history_key_util.dart';
import '../models/hot_key_data.dart';

///  describtion

class SearchLogic extends GetxController {

   final searchNavNotifyId = 'searchNavNotifyId';
   final searchStatusNotifyId = 'searchStatusNotifyId';

   String searchText = '';
   bool searchBarFocus = true;//搜索框是否获取焦点状态
   bool commitSearch = false;//是否搜索

   List<ServiceUsers> serviceUsers = [];//所有技师列表
   List<Projects> projects = [];//所有项目列表
   List<String> historySearchList = [];//历史记录

   List<ServiceUsers> resultUsers = [];//搜索到的技师列表
   List<Projects> resultProjects = [];//搜索到的项目列表


   /*
  * 初始化数据
  * */
   initHistoryData() async {

      historySearchList = await HistoryKeyUtil().readHistory();
      await Future.delayed(const Duration(milliseconds: 300));
      update([searchStatusNotifyId]);

   }

   requestAllData(){
      projects = AppDataTool.instance.projects;
      serviceUsers = AppDataTool.instance.serviceUsers;
   }

   changeSearchText(String text){
      searchText = text;
   }

   changeSearchTextNotify(String text){
      searchText = text;
      update([searchNavNotifyId]);
   }

   changeCommitSearch(){
      HistoryKeyUtil().refreshSearchKey(searchText, historySearchList);
      saveHistoryData();
      resultUsers = [];
      resultProjects = [];
      for(int i = 0;i < serviceUsers.length;i++){
         ServiceUsers serviceUser = serviceUsers[i];
         if((serviceUser.nickname?.length ?? 0) > 0){
            if(serviceUser.nickname!.contains(searchText)){
               resultUsers.add(serviceUser);
            }
         }
      }

      for(int i = 0;i < projects.length;i++){
         Projects project = projects[i];
         if((project.name?.length ?? 0) > 0){
            if(project.name!.contains(searchText)){
               resultProjects.add(project);
            }
         }
      }

      update([searchStatusNotifyId]);
   }

   changeSearchBarFocus(bool focus){
      searchBarFocus = focus;
      update([searchStatusNotifyId]);
   }

   /*
  * 清空历史搜索标签
  * */
   clearHistorySearch(){
      historySearchList = [];
      update([searchStatusNotifyId]);
   }

   /*
  * 保存历史记录
  * */
   saveHistoryData() async {
      HotKeyData data = HotKeyData();
      data.hotKeys = historySearchList;
      await HistoryKeyUtil().saveHistory(data);
   }

   deleteUser(num userId){
      for(int i = 0;i < serviceUsers.length;i++){
         ServiceUsers serviceUser = serviceUsers[i];
         if(serviceUser.id == userId){
            serviceUsers.removeAt(i);
            break;
         }
      }
      resultUsers = [];
      for(int i = 0;i < serviceUsers.length;i++){
         ServiceUsers serviceUser = serviceUsers[i];
         if((serviceUser.nickname?.length ?? 0) > 0){
            if(serviceUser.nickname!.contains(searchText)){
               resultUsers.add(serviceUser);
            }
         }
      }
      update([searchStatusNotifyId]);
   }


}
