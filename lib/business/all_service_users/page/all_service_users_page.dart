import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import 'package:get/get.dart';
import '../../../middle/router_manager.dart';
import '../../../tools/widgets/cupertino_dialog_tool.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../all_projects/widget/sort_title_widget.dart';
import '../../home/widgets/search_navigator_widget.dart';
import '../logic/all_service_users_logic.dart';
import '../widget/all_service_user_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AllServiceUsersPage extends StatefulWidget {

  const AllServiceUsersPage({super.key});

  @override
  State<AllServiceUsersPage> createState() => _AllServiceUsersPageState();

}

class _AllServiceUsersPageState extends State<AllServiceUsersPage> {

  late AllServiceUsersLogic logic;

  @override
  void initState() {
    super.initState();

    List<ServiceUsers>? list = Get.arguments;
    logic = Get.put(AllServiceUsersLogic(allServiceUsers: list ?? []));

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
        '技师列表',
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
        SearchNavigatorWidget(
          searchText: logic.searchText,
          autoFocus: false,
          block: (int type,String value,bool focus){
            _searchBarClick(type,value,focus);
          },
        ),
        GetBuilder<AllServiceUsersLogic>(
          id: logic.sortNotifyId,
          builder: (controller){
            return SortTitleWidget(
              sortName: logic.currentSort(),
              block: (){
                _sortAlert();
              },
            );
          },
        ),
        Expanded(
          child: GetBuilder<AllServiceUsersLogic>(
            id: logic.dataNotifyId,
            builder: (control){
              return ListView.builder(
                itemBuilder: (BuildContext bc,int row){

                  ServiceUsers serviceUser = logic.resultServiceUsers[row];
                  return AllServiceUserCell(serviceUser: serviceUser,
                    block: (){
                      Get.toNamed(Routers.service_user_detail,arguments: serviceUser)?.then((value) {
                        if(value != null && value > 0){
                          logic.deleteUser(value);
                        }
                      });
                    },);
                },
                itemCount: logic.resultServiceUsers.length,
              );
            },
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
      // logic.changeSearchBarFocus(focus);
    }

  }

  _sortAlert(){
    List<Widget> actions = [];
    String alertTitle = '';

    alertTitle = '请选择排序方式';

    actions.add(CupertinoActionSheetAction(
      child: const Text('综合排序'),
      onPressed: () {
        Navigator.pop(context);
        logic.changeSort("综合排序");
      },
    ));
    actions.add(CupertinoActionSheetAction(
      child: const Text('距离排序'),
      onPressed: () {
        Navigator.pop(context);
        logic.changeSort("距离排序");
      },
    ));
    actions.add(CupertinoActionSheetAction(
      child: const Text('接单量排序'),
      onPressed: () {
        Navigator.pop(context);
        logic.changeSort("接单量排序");
      },
    ));

    CupertinoDialogTool().showActionSheet(
        context: context,
        child: CupertinoActionSheet(
          title: Text(alertTitle),
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
        ));
  }

}
