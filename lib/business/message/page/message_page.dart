import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../logic/message_logic.dart';
import '../widget/message_type_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class MessagePage extends StatefulWidget {

  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();

}

class _MessagePageState extends State<MessagePage> {

  late MessageLogic logic;

  @override
  void initState() {
    super.initState();
    logic = Get.put(MessageLogic());
  }

  @override
  void dispose() {

    logic.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeNav() as PreferredSizeWidget?,
      body: _bodyWidgets(),
      // backgroundColor: Colors.white,
    );

  }

  /*
  * 构建导航栏
  * */
  Widget _homeNav() {

    return const CupertinoNavbarIOS(
      middle: Text(
        '消息',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
      ),
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Stack(
      children: [
        GetBuilder<MessageLogic>(
          id: logic.dataNotifyId,
          builder: (control){
            return ListView.builder(
              itemBuilder: (BuildContext bc,int row){

                if(row == 0){
                  return TapContainer(childWidget: MessageTypeCell(type: 1),
                  clickBlock: (){
                    Get.toNamed(Routers.system_message_list);
                  },);
                }
                else if(row == 1){
                  return TapContainer(childWidget: MessageTypeCell(type: 2),
                  clickBlock: (){
                    Get.toNamed(Routers.service_message_list);
                  },);
                }
                else if(row == 2){
                  return TapContainer(childWidget: MessageTypeCell(type: 3),
                  clickBlock: (){
                    Get.toNamed(Routers.chat_list,arguments: 1);
                  },);
                }

                return const SizedBox();

              },
              itemCount: 3,
            );
          },
        ),
        GetBuilder<MessageLogic>(
          id: logic.loadingNotifyId,
          builder: (control){
            return Offstage(
              offstage: !(logic.netLoading),
              child: LoadingProgress(),
            );
          },
        ),
      ],
    );

  }

}
