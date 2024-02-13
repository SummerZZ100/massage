import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massage/middle/my_key_tool.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../model/message_model.dart';
import '../widget/service_message_cell.dart';

///  create by zhangxiaosong on 2023/9/10
///  describtion
///  

class ServiceMessageListPage extends StatefulWidget {

  const ServiceMessageListPage({super.key});

  @override
  State<ServiceMessageListPage> createState() => _ServiceMessageListPageState();
}

class _ServiceMessageListPageState extends State<ServiceMessageListPage> {

  List<MessageModel> list = [];

  @override
  void initState() {
    super.initState();
    _requestServiceMessageList();
  }

  @override
  void dispose() {

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
        '服务通知',
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

    return ListView.builder(
      itemBuilder: (BuildContext bc,int row){

        MessageModel messageModel = list[row];
        return ServiceMessageCell(model: messageModel,);

      },
      itemCount: list.length,
    );

  }

  _requestServiceMessageList()async{

    bool myKey = await MyKeyTool.instance.isMyKey();
    if(myKey){
      Future.delayed(const Duration(milliseconds: 300),(){
        setState((){
          list.add(MessageModel(createTime: "23/09/17",title: "新服务通知！",
              detail: "您预约的全身SPA套餐马上到达约定时间请提前做好准备 !!!"));
        });
      });

    }


  }

}



