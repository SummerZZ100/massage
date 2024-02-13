
import 'package:massage/middle/network/request_interface.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shanyan/shanYanResult.dart';
import 'package:shanyan/shanYanUIConfig.dart';
import 'package:shanyan/shanyan.dart';
import '../../business/login/model/LoginResponse.dart';
import '../../business/main_tab/model/mian_tab_change_tool.dart';
import '../../business/order/model/request_tool_order.dart';
import '../../tools/util/event_bus_zh.dart';
import '../../tools/util/network_manager_zh.dart';
import '../ad_tool/app_config_tool.dart';
import '../ad_tool/model/app_configure_response.dart';
import '../event_bus_name_zh.dart';
import '../network/request_org_model.dart';
import '../system_config.dart';
import '../user_data_tool/user_data_local_tool.dart';

/*
* 闪验 一键登录
* */
class ShanYanTool {

   static final ShanYanTool _instance = ShanYanTool();
   static ShanYanTool get instance => _instance;

   bool? startPage;
   Function? otherLoginBlock;
   Function? successBlock;

  /*
  * 初始化
  * 使用一键登录功能前，必须先进行初始化操作。
  * */
   shanYanInit({bool? startPage, Function? otherLoginBlock,Function? successBlock}){

      this.startPage = startPage;
      this.otherLoginBlock = otherLoginBlock;
      this.successBlock = successBlock;

      toast('加载中...',duration: Toast.LENGTH_SHORT);

      OneKeyLoginManager oneKeyLoginManager = OneKeyLoginManager();
      oneKeyLoginManager.init(appId: SystemConfig.ShanYanAppId).then((shanYanResult) {
         // int? code; //返回码code为1000:成功；其他：失败
         // String? message; //描述
         // int? innerCode; //内层返回码
         // String? innerDesc; //内层事件描述
         // String? token; //token
         _shanYanGetPhoneInfo();

         });

   }

   /*
   * 预取号
   * **建议在判断当前用户属于未登录状态时使用，**已登录状态用户请不要调用该方法
   * 建议在执行拉取授权登录页的方法前，提前一段时间调用预取号方法，中间最好有2-3秒的缓冲（因为预取号方法需要1~3s的时间取得临时凭证）
   * 请勿频繁的多次调用、请勿与拉起授权登录页同时和之后调用。
   * 避免大量资源下载时调用，例如游戏中加载资源或者更新补丁的时候要顺序执行
   * */
   _shanYanGetPhoneInfo(){

      OneKeyLoginManager oneKeyLoginManager = OneKeyLoginManager();
      oneKeyLoginManager.getPhoneInfo().then((ShanYanResult shanYanResult) {
         // int? code; //返回码code为1000:成功；其他：失败
         // String? message; //描述
         // int? innerCode; //内层返回码
         // String? innerDesc; //内层事件描述
         // String? token; //token
         _shanYanOpenLoginAuth();

      });

   }

   /*
   * 拉起授权页
   * 调用拉起授权页方法后将会调起运营商授权页面。已登录状态请勿调用 。
   * 每次调用拉起授权页方法前均需先调用授权页配置方法，否则授权页可能会展示异常。
   * */
   _shanYanOpenLoginAuth(){
      OneKeyLoginManager oneKeyLoginManager = OneKeyLoginManager();

      _shanYanWidgetConfig(oneKeyLoginManager: oneKeyLoginManager);

      oneKeyLoginManager.addClikWidgetEventListener((shanYanWidgetEvent) {
         if(shanYanWidgetEvent == 'other_custom_button'){
            if(otherLoginBlock != null){
               otherLoginBlock!();
            }
         }
      });

      oneKeyLoginManager.setOneKeyLoginListener((ShanYanResult shanYanResult) {

         // code	Int	code为1000:成功；其他：失败
         // message	String	描述
         // innerCode	Int	内层返回码
         // innerDesc	String 	内层事件描述
         // token	String 	token

         print("shanyan  ==  ${shanYanResult.code}  ${shanYanResult.message}  ${shanYanResult.innerCode}  ${shanYanResult.token}");

         if (1000 == shanYanResult.code) {
            _requestShanYanLogin(
                token: shanYanResult.token ?? '',
                oneKeyLoginManager: oneKeyLoginManager,
            );
         } else if (1011 == shanYanResult.code){
            ///点击返回/取消 （强制自动销毁）
            // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
         }else{
            ///一键登录获取token失败
            //关闭授权页
            toast('获取token失败');
         }
      });


      oneKeyLoginManager.openLoginAuth().then((ShanYanResult shanYanResult) {

         // code	Int	code为1000:成功；其他：失败
         // message	String	描述
         // innerCode	Int	内层返回码
         // innerDesc	String 	内层事件描述
         // token	String 	token（成功情况下返回）用来后台置换手机号。一次有效。

         print("openLoginAuth  ==  ${shanYanResult.code}  ${shanYanResult.message}  ${shanYanResult.innerCode}  ${shanYanResult.token}");

         if (1000 == shanYanResult.code) {
            //拉起授权页成功
         } else {
            //拉起授权页失败
            if(otherLoginBlock != null){
               otherLoginBlock!();
            }
         }
      });

   }

   _shanYanWidgetConfig({required OneKeyLoginManager oneKeyLoginManager}){
      
      ShanYanUIConfig shanYanUIConfig = ShanYanUIConfig();

      /*iOS 页面样式设置*/
      shanYanUIConfig.ios.isFinish = true;
      shanYanUIConfig.ios.setPreferredStatusBarStyle = iOSStatusBarStyle.styleDefault;
      shanYanUIConfig.ios.setStatusBarHidden = false;
      shanYanUIConfig.ios.setAuthNavHidden = false;
      shanYanUIConfig.ios.setNavReturnImgHidden = false;
      shanYanUIConfig.ios.setNavigationBarStyle = iOSBarStyle.styleBlack;
      shanYanUIConfig.ios.setAuthNavTransparent = false;

      shanYanUIConfig.ios.setNavigationBottomLineHidden = false;

      shanYanUIConfig.ios.setLogoHidden = false;
      shanYanUIConfig.ios.setLogoImgPath = "appLogo";

      shanYanUIConfig.ios.setNumberColor = "#000000";
      shanYanUIConfig.ios.setNumberSize = 24;
      shanYanUIConfig.ios.setNumberBold = true;
      shanYanUIConfig.ios.setNumberTextAlignment = iOSTextAlignment.center;

      shanYanUIConfig.ios.setLogBtnText = "一键登录";
      shanYanUIConfig.ios.setLogBtnTextColor = "#FFFFFF";
      shanYanUIConfig.ios.setLoginBtnTextSize = 18;
      shanYanUIConfig.ios.setLoginBtnTextBold = false;
      shanYanUIConfig.ios.setLoginBtnBgColor =  "#FF4C8EF8";
      shanYanUIConfig.ios.setLoginBtnCornerRadius = 8;

      shanYanUIConfig.ios.setPrivacyTextSize = 13;
      shanYanUIConfig.ios.setPrivacyTextBold = false;

      shanYanUIConfig.ios.setAppPrivacyTextAlignment = iOSTextAlignment.center;
      shanYanUIConfig.ios.setPrivacySmhHidden = true;
      shanYanUIConfig.ios.setAppPrivacyLineSpacing = 5;
      shanYanUIConfig.ios.setAppPrivacyNeedSizeToFit = false;
      shanYanUIConfig.ios.setAppPrivacyAbbreviatedName = "我们";
      shanYanUIConfig.ios.setAppPrivacyColor = ["#808080", "#4C8EF8"];

      shanYanUIConfig.ios.setAppPrivacyNormalDesTextFirst = "登录或注册代表我已同意";
//    shanYanUIConfig.ios.setAppPrivacyTelecom = "中国移动服务协议";
      shanYanUIConfig.ios.setAppPrivacyNormalDesTextSecond = "和";
      shanYanUIConfig.ios.setAppPrivacyFirst = ["《用户协议》", "https://imgs.ituiuu.cn/cdn/pages/useagreement.html"];
      shanYanUIConfig.ios.setAppPrivacyNormalDesTextThird = "、";
      shanYanUIConfig.ios.setAppPrivacySecond = ["《隐私政策》", "https://imgs.ituiuu.cn/cdn/pages/privacy.html"];

      shanYanUIConfig.ios.setAppPrivacyWebPreferredStatusBarStyle = iOSStatusBarStyle.styleDefault;
      shanYanUIConfig.ios.setAppPrivacyWebNavigationBarStyle = iOSBarStyle.styleDefault;

//运营商品牌标签("中国**提供认证服务")，不得隐藏
      shanYanUIConfig.ios.setSloganTextSize = 12;
      shanYanUIConfig.ios.setSloganTextBold = false;
      shanYanUIConfig.ios.setSloganTextColor = "#4C8EF8";
      shanYanUIConfig.ios.setSloganTextAlignment = iOSTextAlignment.center;

//供应商品牌标签("创蓝253提供认技术支持")
      shanYanUIConfig.ios.setShanYanSloganTextSize = 12;
      shanYanUIConfig.ios.setShanYanSloganTextBold = true;
      shanYanUIConfig.ios.setShanYanSloganTextColor = "#4C8EF8";
      shanYanUIConfig.ios.setShanYanSloganTextAlignment = iOSTextAlignment.center;
      shanYanUIConfig.ios.setShanYanSloganHidden = false;

      shanYanUIConfig.ios.setCheckBoxHidden = false;
      shanYanUIConfig.ios.setPrivacyState = false;
      shanYanUIConfig.ios.setCheckBoxVerticalAlignmentToAppPrivacyCenterY = true;
      shanYanUIConfig.ios.setUncheckedImgPath = "phone_unchecked";
      shanYanUIConfig.ios.setCheckedImgPath =  "phone_checked";
      shanYanUIConfig.ios.setCheckBoxWH = [20,20];

      shanYanUIConfig.ios.setLoadingCornerRadius = 20;
      shanYanUIConfig.ios.setLoadingBackgroundColor = "#FFFFFF";
      shanYanUIConfig.ios.setLoadingTintColor = "#4C8EF8";

      shanYanUIConfig.ios.setShouldAutorotate = false;
      shanYanUIConfig.ios.supportedInterfaceOrientations = iOSInterfaceOrientationMask.all;
      shanYanUIConfig.ios.preferredInterfaceOrientationForPresentation = iOSInterfaceOrientation.portrait;

      shanYanUIConfig.ios.setAuthTypeUseWindow = true;
      shanYanUIConfig.ios.setAuthWindowCornerRadius = 10;

      shanYanUIConfig.ios.setAuthWindowModalTransitionStyle = iOSModalTransitionStyle.flipHorizontal;
      shanYanUIConfig.ios.setAppPrivacyWebModalPresentationStyle = iOSModalPresentationStyle.fullScreen;
      shanYanUIConfig.ios.setAuthWindowOverrideUserInterfaceStyle = iOSUserInterfaceStyle.unspecified;

      shanYanUIConfig.ios.setAuthWindowPresentingAnimate = true;

      //弹窗中心位置
      // shanYanUIConfig.ios.layOutPortrait.setAuthWindowOrientationCenterX = screenWidthPortrait*0.5;
      // shanYanUIConfig.ios.layOutPortrait.setAuthWindowOrientationCenterY = screenHeightPortrait*0.5;

      shanYanUIConfig.ios.layOutPortrait.setAuthWindowOrientationWidth = 300;
      // shanYanUIConfig.ios.layOutPortrait.setAuthWindowOrientationHeight = screenWidthPortrait*0.7;

      //logo
      shanYanUIConfig.ios.layOutPortrait.setLogoTop = 100;
      shanYanUIConfig.ios.layOutPortrait.setLogoWidth = 80;
      shanYanUIConfig.ios.layOutPortrait.setLogoHeight = 80;
      shanYanUIConfig.ios.layOutPortrait.setLogoCenterX = 0;
      //手机号控件
      shanYanUIConfig.ios.layOutPortrait.setNumFieldTop = 240;
      shanYanUIConfig.ios.layOutPortrait.setNumFieldCenterX = 0;
      shanYanUIConfig.ios.layOutPortrait.setNumFieldHeight = 30;
      shanYanUIConfig.ios.layOutPortrait.setNumFieldWidth = 150;
      //一键登录按钮
      shanYanUIConfig.ios.layOutPortrait.setLogBtnTop = 340;
      shanYanUIConfig.ios.layOutPortrait.setLogBtnCenterX = 0;
      shanYanUIConfig.ios.layOutPortrait.setLogBtnHeight = 40;
      shanYanUIConfig.ios.layOutPortrait.setLogBtnWidth = 300;

      //授权页 创蓝slogan（创蓝253提供认证服务）
      shanYanUIConfig.ios.layOutPortrait.setShanYanSloganHeight = 20;
      shanYanUIConfig.ios.layOutPortrait.setShanYanSloganLeft = 0;
      shanYanUIConfig.ios.layOutPortrait.setShanYanSloganRight = 0;
      shanYanUIConfig.ios.layOutPortrait.setShanYanSloganBottom = 30;

      //授权页 slogan（***提供认证服务）
      shanYanUIConfig.ios.layOutPortrait.setSloganHeight = 20;
      shanYanUIConfig.ios.layOutPortrait.setSloganLeft = 0;
      shanYanUIConfig.ios.layOutPortrait.setSloganRight = 0;
      shanYanUIConfig.ios.layOutPortrait.setSloganBottom = (shanYanUIConfig.ios.layOutPortrait.setShanYanSloganBottom ?? 0)
          + (shanYanUIConfig.ios.layOutPortrait.setShanYanSloganHeight ?? 0);

      //隐私协议
      shanYanUIConfig.ios.layOutPortrait.setPrivacyHeight = 60;
      shanYanUIConfig.ios.layOutPortrait.setPrivacyLeft = 30;
      shanYanUIConfig.ios.layOutPortrait.setPrivacyRight = 30;
      shanYanUIConfig.ios.layOutPortrait.setPrivacyBottom = (shanYanUIConfig.ios.layOutPortrait.setSloganBottom ?? 0)
          + (shanYanUIConfig.ios.layOutPortrait.setShanYanSloganHeight ?? 0);


      List<ShanYanCustomWidgetIOS> shanyanCustomWidgetIOS = [];

      final String btn_widgetId = "other_custom_button"; // 标识控件 id
      ShanYanCustomWidgetIOS buttonWidgetiOS = ShanYanCustomWidgetIOS(btn_widgetId, ShanYanCustomWidgetType.Button);
      buttonWidgetiOS.textContent = "其他号码登录";
      // buttonWidgetiOS.centerY = -50;
      buttonWidgetiOS.top = 400;
      buttonWidgetiOS.centerX = 0 ;
      buttonWidgetiOS.width = 200;
      buttonWidgetiOS.textColor = "#4C8EF8";
      buttonWidgetiOS.height = 40;
      buttonWidgetiOS.backgroundColor = "#FFFFFF";
      buttonWidgetiOS.cornerRadius = 20;
      buttonWidgetiOS.isFinish = true;
      buttonWidgetiOS.textFont = 15;
      buttonWidgetiOS.textAlignment = iOSTextAlignment.center;

      if(startPage != true){
         shanyanCustomWidgetIOS.add(buttonWidgetiOS);
      }

      shanYanUIConfig.ios.widgets = shanyanCustomWidgetIOS;

      oneKeyLoginManager.setAuthThemeConfig(uiConfig: shanYanUIConfig);

   }

   _requestShanYanLogin({required String token,required OneKeyLoginManager oneKeyLoginManager}) async {

      RequestOrgModel requestOrgModel = await RequestInterface.requestShanYanLogin(token: token);

      NetworkManagerZH manager = NetworkManagerZH.instance;
      manager.post(requestOrgModel.requestUrl,queryParameters: requestOrgModel.requestJson).then((value) {
         if(value != null){
            LoginResponse response = LoginResponse.fromJson(value);
            if(response.code == 200 && response.data != null){
               UserDataLocalTool.instance.login(
                  data: response.data!,
               ).then((value) async {

                  await RequestToolOrder.instance.defaultUserOrderList();
                  await _requestAppConfigInfo();

                  EventBusZH().emit(EventBusNameZH.RefreshHomePageEventId);
                  EventBusZH().emit(EventBusNameZH.RefreshPhysioPageEventId);
                  EventBusZH().emit(EventBusNameZH.RefreshMessagePageEventId);
                  EventBusZH().emit(EventBusNameZH.RefreshMinePageEventId);

                  MainTabChangeTool.instance.changeToPhysioTab(500);

                  if(successBlock != null) {
                     successBlock!();
                  }
                  oneKeyLoginManager.finishAuthControllerCompletion();

               });

            }
            else{
               oneKeyLoginManager.finishAuthControllerCompletion();
               toast(response.msg ?? "登录失败，请重新登录");
            }
         }

      });

   }

   _requestAppConfigInfo() async {

      String settingUrl = await RequestInterface.requestSettingConfig(token: UserDataLocalTool.instance.userInfo?.key);
      var value = await NetworkManagerZH.instance.get(settingUrl);
      if(value != null){
         AppConfigureResponse res = AppConfigureResponse.fromJson(value);
         if(res.code == 200){
            AppConfigTool.instance.appConfigData = res.configData;
         }
      }

   }

}