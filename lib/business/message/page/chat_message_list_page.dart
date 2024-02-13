import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massage/business/message/widget/receive_message_cell.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../logic/chat_message_list_logic.dart';
import '../model/message_model.dart';
import '../widget/chat_edit_bottom_widget.dart';
import '../widget/send_message_cell.dart';

///  create by zhangxiaosong on 2023/9/10
///  describtion
///  

class ChatMessageListPage extends StatefulWidget {

  const ChatMessageListPage({super.key});

  @override
  State<ChatMessageListPage> createState() => _ChatMessageListPageState();
}

class _ChatMessageListPageState extends State<ChatMessageListPage> {

  late ChatMessageListLogic logic;
  int type = 1;

  @override
  void initState() {
    super.initState();
    type = Get.arguments;
    logic = Get.put(ChatMessageListLogic());
    logic.requestHistoryServiceMessageList();
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
      middle: Text(
        type == 1 ? '店铺客服' : '在线客服',
        style:const TextStyle(
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
        Expanded(child: GetBuilder<ChatMessageListLogic>(
            id: logic.dataNotifyId,
            builder: (controller){
              return TapContainer(childWidget: ListView.builder(
                itemBuilder: (BuildContext bc,int row){

                  MessageModel messageModel = logic.list[row];
                  if(messageModel.type == 1){
                    return SendMessageCell(model: messageModel,);
                  }
                  else{
                    return ReceiveMessageCell(model: messageModel,);
                  }

                },
                itemCount: logic.list.length,
                // reverse: true,
              ),
                clickBlock: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              );
            })),
        ChatEditBottomWidget(block: (String text){
           _sendMessage(text);
        },),
      ],
    );

  }

  _sendMessage(String text){
    logic.sendMessage(text);
  }



}



