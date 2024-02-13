
import 'package:massage/middle/ad_tool/app_config_tool.dart';
import 'package:massage/middle/network/request_org_model.dart';

import '../../tools/util/encode_util.dart';
import '../../tools/util/system_info_zh.dart';
import '../location_data_tool.dart';
import '../shanyan_tool/Shanyan_login_request.dart';
import '../system_config.dart';
import '../url_i.dart';
import '../user_data_tool/user_data_local_tool.dart';
import 'root_p_request.dart';

class RequestInterface {


  /*
  * 基础数据
  * */
  static Future<String> baseParams() async {

    // String udid = await SystemInfoZH.hardIMEI();
    String tdid = await UrlI.urlTDID();
    String idfa = await SystemInfoZH.idfa();
    String device = await SystemInfoZH.deviceModel();
    device = device.replaceAll(' ', '-');
    device = device.replaceAll(',', '-');
    String packageVersion = await SystemInfoZH.packageVersion();

    RootPRequest publicRequest = RootPRequest();
    publicRequest.veruaof = packageVersion;
    String client = 'iPhone';
    if(SystemInfoZH.osPlatform() == PlatformType.android){
      client = 'android';
    }
    publicRequest.hlaefm = client;
    publicRequest.devahe = device;
    publicRequest.adni = idfa;
    // publicRequest.devahe_mokef = "";
    publicRequest.mdad = tdid;
    publicRequest.lfg =  LocationDataTool.instance.lng;
    publicRequest.lim =  LocationDataTool.instance.lat;
    publicRequest.appname = SystemConfig.appName;

    String params = '&veruaof=${publicRequest.veruaof}&hlaefm=${publicRequest.hlaefm}&devahe=${publicRequest.devahe}';
    if((publicRequest.adni?.length ?? 0) > 0){
      params += '&adni=${publicRequest.adni}';
    }
    if((publicRequest.mdad?.length ?? 0) > 0){
      params += '&mdad=${publicRequest.mdad}';
    }

    params += '&lfg=${publicRequest.lfg}';
    params += '&lim=${publicRequest.lim}';

    if((publicRequest.appname?.length ?? 0) > 0){
      params += '&appname=${publicRequest.appname}';
    }

    SystemConfig.publicParamsStr = params;

    return params;

  }

  /*
  * 签名
  * */
  static String signature(){

    DateTime dateTime = DateTime.now();

    String hourStr = '${dateTime.hour}';

    if(dateTime.hour < 10){
      hourStr = '0${dateTime.hour}';
    }
    String sign = EncodeUtil.instance!.generateMd5('${SystemConfig.appName}$hourStr');
    return sign;

  }

  /*
  * 请求登录获取短信验证码
  * */
  static Future<String> requestLoginMessageCode({String? phone}) async {

    String baseParam = await baseParams();

    String url = '${UrlI.userUrl()}$baseParam&mobile=$phone&signature=${signature()}';

    return url;

  }

  /*
  * 请求登录
  * */
  static Future<String> requestLogin({String? phone,String? code}) async {

    String baseParam = await baseParams();

    String url = '${UrlI.userUrl()}$baseParam&mobile=$phone&code=$code&signature=${signature()}';

    return url;

  }

  /*
  * 请求闪验登录
  * */
  static Future<RequestOrgModel> requestShanYanLogin({String? token}) async {

    RequestOrgModel requestOrgModel = RequestOrgModel();
    String baseParam = await baseParams();

    String url = '${UrlI.userUrl()}$baseParam';//&token=$token&signature=${signature()}
    requestOrgModel.requestUrl = url;
    ShanyanLoginRequest request = ShanyanLoginRequest();
    request.signature = signature();
    request.result = "{\"token\":\"$token\"}";
    requestOrgModel.requestJson = request.toJson();

    return requestOrgModel;

  }

  /*
  * 请求配置信息
  * */
  static Future<String> requestSettingConfig({String? token}) async {

    String baseParam = await baseParams();

    String keyStr = '';
    if((token?.length ?? 0) > 0){
      keyStr = '&key=$token';
    }
    String url = '${UrlI.urlSetting()}$baseParam$keyStr&signature=${signature()}';

    return url;

  }

  //动态
  static String myH5Url(){
    if(UserDataLocalTool.instance.userInfo?.key != null && (UserDataLocalTool.instance.userInfo?.key?.length ?? 0) > 0){
      return '${UrlI.urlH5()}key=${UserDataLocalTool.instance.userInfo?.key}'
          '${SystemConfig.publicParamsStr}&kefu=${AppConfigTool.instance.appConfigData?.kefu ?? ""}';
    }
    else{
      String publicParamsStr = SystemConfig.publicParamsStr;
      publicParamsStr = publicParamsStr.replaceFirst("&", "");
      return '${UrlI.urlH5()}$publicParamsStr';
    }


  }

  /*
  * 请求首页数据
  * */
  static Future<String> requestMainData() async {

    String url = 'https://imgs.ituiuu.cn/cdn/actData.json';

    return url;

  }

  /*
  * 退出登录
  * */
  static Future<String> requestExit({String? key}) async {
    String baseParam = await baseParams();
    String url = '${UrlI.userUrl()}$baseParam&key=$key';
    return url;
  }

  /*
  * 创建订单
  * */
  static Future<String> requestCreateOrder({String? key,num? serviceUserId,num? cateId,num? price,int? type}) async {

    String baseParam = await baseParams();

    String url = '${UrlI.urlOrder()}$baseParam&key=$key&user_id=$serviceUserId&cate_id=$cateId&price=$price'
        '&type=$type&auto=1&src=0';

    return url;

  }

  /*
  * 注销账号提示文案
  * */
  static Future<String> requestLogOffAlert({String? key}) async {

    String baseParam = await baseParams();

    String url = '${UrlI.userUrl()}$baseParam&cancel_member=1&key=$key';

    return url;

  }

  /*
  * 注销账号
  * */
  static Future<String> requestLogOff({String? key}) async {

    String baseParam = await baseParams();

    String url = '${UrlI.userUrl()}$baseParam&cancel_member=1&key=$key&signature=${signature()}';

    return url;

  }

  /*
  * 逆地理位置
  * */
  static String requestRegeo({required String log,required String lat}){

    return "https://restapi.amap.com/v3/geocode/regeo?key=6ee4aa84dd0f4d63be32fe4eb7df160c&location=$log,$lat";

  }












}