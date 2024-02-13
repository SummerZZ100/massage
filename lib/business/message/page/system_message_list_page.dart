import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massage/middle/my_key_tool.dart';

import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../model/message_model.dart';
import '../widget/system_message_cell.dart';

///  create by zhangxiaosong on 2023/9/10
///  describtion
///  

class SystemMessageListPage extends StatefulWidget {

  const SystemMessageListPage({super.key});

  @override
  State<SystemMessageListPage> createState() => _SystemMessageListPageState();
}

class _SystemMessageListPageState extends State<SystemMessageListPage> {

  List<MessageModel> list = [];

  @override
  void initState() {
    super.initState();
    _requestSystemMessageList();
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
        '系统消息',
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
        return SystemMessageCell(model: messageModel,);

      },
      itemCount: list.length,
    );

  }

  _requestSystemMessageList()async{

    bool myKey = await MyKeyTool.instance.isMyKey();
    if(myKey){
      Future.delayed(const Duration(milliseconds: 300),(){
        setState((){
          list.add(MessageModel(createTime: "09月12日  00:00",title: "您的优惠券已送达！",
              detail: "恭喜您获得本系统优惠券，请前往优惠券列表中进行领取"));

          list.add(MessageModel(createTime: "09月10日  14:20",title: "您的账号注册成功！",
              detail: "欢迎您来到这里，在这里您可以受到贴心的呵护，在按摩中快乐生活"));
        });
      });

    }
  }

}



