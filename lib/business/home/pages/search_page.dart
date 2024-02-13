import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massage/business/home/logic/search_logic.dart';
import '../../../middle/router_manager.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../all_service_users/widget/all_service_user_cell.dart';
import '../models/Projects.dart';
import '../models/ServiceUsers.dart';
import '../widgets/product_info_cell.dart';
import '../widgets/search_history_cell.dart';
import '../widgets/search_navigator_widget.dart';

///  describtion

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late SearchLogic logic;

  @override
  void initState() {
    super.initState();

    logic = Get.put(SearchLogic());
    logic.requestAllData();
    logic.initHistoryData();

  }

  @override
  void dispose() {

    logic.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageNav() as PreferredSizeWidget?,
      body: _bodyWidgets(),
    );

  }

  /*
  * 构建导航栏
  * */
  Widget _pageNav() {

    return CupertinoNavbarIOS(
      middle: const Text(
        '搜索',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
      ),
      leading: NavBackButtonZH(
        LeftIconType.back,
      ),
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Column(
      children: [
        GetBuilder<SearchLogic>(
            id: logic.searchNavNotifyId,
            builder: (controller){
              return SearchNavigatorWidget(
                searchText: logic.searchText,
                autoFocus: true,
                block: (int type,String value,bool focus){
                  _searchBarClick(type,value,focus);
                },
              );
            }),
        Expanded(
          child: Stack(
            children: [
               GetBuilder<SearchLogic>(
                   id: logic.searchStatusNotifyId,
                   builder:(controller){
                     return Offstage(
                       offstage: !(logic.searchBarFocus),
                       child: ListView.builder(
                          itemBuilder: (BuildContext bc,int row){
                            return SearchHistoryCell(
                              list: logic.historySearchList,
                              block: (int type,String title){
                                _historyLabelClick(type,title);
                              },
                            );
                          },
                          itemCount: 1,
                       ),
                     );
                   }),
              GetBuilder<SearchLogic>(
                  id: logic.searchStatusNotifyId,
                  builder:(controller){
                    return Offstage(
                      offstage: logic.searchBarFocus,
                      child: ListView.builder(
                        itemBuilder: (BuildContext bc,int row){
                          if(logic.resultUsers.length > row){
                            ServiceUsers serviceUser = logic.resultUsers[row];
                            return AllServiceUserCell(serviceUser: serviceUser,
                              block: (){
                                Get.toNamed(Routers.service_user_detail,arguments: serviceUser)?.then((value) {
                                  if(value != null && value > 0){
                                    logic.deleteUser(value);
                                  }
                                });
                              },);
                          }
                          else if(logic.resultUsers.length + logic.resultProjects.length > row){
                            Projects project = logic.resultProjects[row - logic.resultUsers.length];
                            return ProductInfoCell(project: project,
                              block: (){
                                _goDetail(project);
                              },);
                          }
                          else{
                            return const SizedBox();
                          }
                        },
                        itemCount: logic.resultUsers.length + logic.resultProjects.length,
                      ),
                    );
                  }),
            ],
          ),
        )
      ],
    );
  }

  /*
  * 搜索导航栏交互
  *  type  2：编辑文字  3: 搜索  4: 获取焦点的状态
  * */
  _searchBarClick(int type,String value,bool focus) async {
    if(type == 2){//编辑
      logic.changeSearchText(value);
    }
    else if(type == 3){//搜索
      logic.changeCommitSearch();
    }
    else if(type == 4){//获取焦点的状态
      logic.changeSearchBarFocus(focus);
    }

  }

  /*
  * 搜索历史点击
  *
  * */
  _historyLabelClick(int type,String value) {
    if (type == 1) {

      logic.changeSearchTextNotify(value);

      if (logic.searchBarFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
        logic.changeCommitSearch();
      }
      else {
        logic.changeCommitSearch();
      }
    }
    else {
      logic.clearHistorySearch();
    }
  }

  _goDetail(Projects project){
    Get.toNamed(Routers.project_detail,arguments: project);
  }

}
