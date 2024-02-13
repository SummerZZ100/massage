import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massage/business/comment/logic/comment_list_logic.dart';
import 'package:massage/business/comment/model/comment_model.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../widget/comment_cell_widget.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class CommentListPage extends StatefulWidget {

  const CommentListPage({super.key});

  @override
  State<CommentListPage> createState() => _CommentListPageState();

}

class _CommentListPageState extends State<CommentListPage> {

  late CommentListLogic logic;

  @override
  void initState() {
    super.initState();

    logic = Get.put(CommentListLogic());

    logic.requestComments();
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
        '评价列表',
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

    return GetBuilder<CommentListLogic>(
      id: logic.dataNotifyId,
      builder: (control){
        return ListView.builder(
          itemBuilder: (BuildContext bc,int row){

            CommentModel model = logic.list[row];
            return CommentCellWidget(model:model);

          },
          itemCount: logic.list.length,
        );
      },
    );

  }
}
