import 'dart:math';

import 'package:get/get.dart';

import '../model/message_model.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class ChatMessageListLogic extends GetxController{

  List<MessageModel> list = [];

  final dataNotifyId = 'dataNotifyId';
  final loadingNotifyId = 'loadingNotifyId';

  var netLoading = false;

  requestHistoryServiceMessageList(){

    // list.add(MessageModel(createTime: "23/09/13",title: "新服务通知！",
    //     detail: "您预约的全身SPA套餐马上到达约定时间请提前做好准备 !!!",type: 1));


    // update([dataNotifyId]);

  }

  sendMessage(String text){

    if(text.isNotEmpty){
      list.add(MessageModel(createTime: "",title: "",
          detail: text,type: 1));

      _receiveMessage();

      update([dataNotifyId]);
    }

  }

  _receiveMessage(){

    int count = Random().nextInt(3);
    while (count == 0){
      count = Random().nextInt(3);
    }

    Future.delayed(Duration(milliseconds: count*1000),(){

      list.add(MessageModel(createTime: "",title: "",
          detail: "尊敬的用户，您好！当前客服不在线，请耐心等待，我们看到消息后会第一时间回复您。感谢您的理解!",type: 2));

      update([dataNotifyId]);
    });

  }

}