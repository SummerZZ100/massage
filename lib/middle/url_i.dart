import 'package:talkingdata_sdk_plugin/talkingdata_sdk_plugin.dart';

///  接口 / 链接 url配置


class UrlI {


  /*
  * 接口地址
  * */
  static String userUrl(){
    return 'https://amshf.ituiuu.cn/sign/?a=index';
  }

  /*
  * H5 url
  * */
  static String urlH5(){
    return 'https://amshf.ituiuu.cn/find/?';
  }

  /*
  * 配置（设置）url
  * */
  static String urlSetting(){
    return 'https://amshf.ituiuu.cn/sign/?a=my';
  }

  /*
  * 创建订单 url
  * */
  static String urlOrder(){
    return 'https://amshf.ituiuu.cn/sign/?a=need';
  }

  /*
  * 接口TokenData 唯一ID
  * */
  static Future<String> urlTDID() async{

    String token = await TalkingDataSDK.getDeviceID();
    return token;

  }



}
