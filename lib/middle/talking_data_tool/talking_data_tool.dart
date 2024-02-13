import 'package:talkingdata_sdk_plugin/talkingdata_sdk_plugin.dart';

///  describtion


class TalkingDataTool {

  static onEvent(int tab){

    String eventId = '';
    if(tab == 0){
      eventId = '首页';
    }
    else if(tab == 1){
      eventId = '理疗师';
    }
    else if(tab == 2){
      eventId = '消息';
    }
    else if(tab == 3){
      eventId = '我的';
    }

    TalkingDataSDK.onEvent(eventId: eventId);
    
  }
  
  static initTalkingData()async{
    await TalkingDataSDK.init(appID: "B3C544635FF34834AB295542E398A24F", channelID: "AppStore",custom: "");
  }

}