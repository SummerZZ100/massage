/*
@Date: 2020/8/11
@author: zhangxiaosong
@describe webview
**/

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../middle/router_manager.dart';
import '../../../business/create_order/model/AlipayData.dart';
import '../../../business/create_order/model/WechatData.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/util/system_info_zh.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../event_bus_name_zh.dart';
import '../../network/request_interface.dart';
import '../../widget/alert_app_widget.dart';
import '../model/js_params.dart';
import '../widget/webview_navigator.dart';
import '../widget/webview_navigator_s.dart';
import '../controller/webview_zh_controlller.dart';
import 'package:fluwx/fluwx.dart' as Wechat;
import 'package:tobias/tobias.dart' as tobias;


/*
* webview视图 顶部状态栏颜色
* */
enum WebViewStatusBarStyle {
  light,
  dark
}

/*
* 回调方法
* type 1: 刷新页面  2：数据处理
* jsonParams: 传回的json数据
* */
typedef WebViewZHPageBlock = Function(int type,String jsonParams);

class WebViewZHPage extends StatefulWidget {

  WebViewZHPageBlock? block;
  WebViewStatusBarStyle? statusBarStyle;//顶部状态栏颜色
  bool? addListener = false;
  String originalWebUrl;//网络加载页
  bool? backHome;
  bool? share;//是否展示右侧分享按钮
  String? thumbnail;//分享weburl时的图片
  String? title;//标题

  bool? showNavigationBar;//是否展示导航栏
  bool? inHomeTab;//是否处于首页tab
  bool? showCircleProgress;// 是否展示加载圈
  int loadingStyle = 0;// 0: 默认显示自定义加载图 1：显示转圈加载图
  double? topSpace;
  bool? showLeftBtn;
  bool? isSecondTab;

  WebViewZHPage({required this.originalWebUrl,
    this.statusBarStyle,this.addListener,this.backHome,this.showLeftBtn,this.share,
    this.title,this.thumbnail,this.inHomeTab,this.isSecondTab,this.block}){

    statusBarStyle ??= WebViewStatusBarStyle.dark;
    addListener ??= false;
    if(isSecondTab == true){
      if(originalWebUrl.isEmpty){
        originalWebUrl = RequestInterface.myH5Url();
      }
    }
    originalWebUrl = Uri.encodeFull(originalWebUrl);
    share ??= false;

  }

  @override
  _WebViewZHPageState createState() => _WebViewZHPageState();

}

class _WebViewZHPageState extends State<WebViewZHPage> with TickerProviderStateMixin,RouteAware{

  WebViewController? _controller;//webView视图控制器
  late String currentUrl;
  bool firstLoad = true;
  late WebViewZHController myController;

  bool needRefresh = false;//是否需要清空刷新

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if(widget.inHomeTab != true){
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // }

    if(SystemInfoZH.osPlatform() == PlatformType.android){
      WebView.platform = SurfaceAndroidWebView();
    }

    Future.delayed(const Duration(milliseconds: 600),(){
      _eventBusListener();
    });

    RouterManager.webViewId += RouterManager.webViewId + 1;
    myController = Get.put(WebViewZHController(),tag: '${RouterManager.webViewId}');

    _addWechatHandler();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(mounted){
      context.dependOnInheritedWidgetOfExactType();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {

    _eventBusOff();
    if(_controller != null){
      _controller = null;
    }

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    myController.dispose();

    super.dispose();

  }

  @override
  void didPop() {

    super.didPop();
    // print('=== didPop');
  }

  @override
  void didPopNext() async{

    super.didPopNext();

    if(widget.addListener == true && needRefresh == true){
      needRefresh = false;
      _controller!.clearCache();
    }

  }

  @override
  void didPush() {

    super.didPush();
  }

  @override
  void didPushNext() {

    super.didPushNext();
  }

  /*
  * 进入页面时如果页面为空白页则重新加载
  * */
  _rebuild() async{

    if(widget.addListener == true){
      String? s = await _controller?.currentUrl();
      if((s?.length ?? 0) == 0 && _controller != null){
        await _controller!.loadUrl(widget.originalWebUrl);
        _controller!.clearCache();
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    _rebuild();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Column(
              children: [
                GetBuilder<WebViewZHController>(
                    id: myController.navStatus,
                    tag: '${RouterManager.webViewId}',
                    builder: (controller){
                      return _navigationWidget(controller);
                    }),
                Expanded(
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,//js调用方式
                    initialUrl: widget.originalWebUrl, // 加载的url
                    onProgress: (int progress){// 加载进度
                      if(mounted){
                        myController.changeProgress(progress);
                        if(progress > 70 && myController.isLoading == true){
                          myController.changeLoadingStatus(false);
                        }
                      }
                    },
                    onWebViewCreated: (WebViewController web) {//创建webview

                      _controller = web;
                      if(firstLoad == true){
                        firstLoad = false;
                      }

                    },
                    onPageFinished: (String value) {
                      // webview 页面加载调用
                      currentUrl = value;
                      if(mounted){
                        _changeTitle();
                      }
                    },
                    javascriptChannels: <JavascriptChannel>{

                      _toasterJavascriptChannel(this.context),

                    },
                    onPageStarted: (String url){
                      print('onPageStarted  url  = $url');
                    },
                    navigationDelegate: (NavigationRequest request){// NavigationDecision.navigate:允许导航发生
                      if(request.url == 'page://success'){

                        return NavigationDecision.prevent;

                      }
                      else{
                        return NavigationDecision.navigate;
                      }

                    },
                    // userAgent: '',
                  ),
                )
              ],
            ),
          ),
          GetBuilder<WebViewZHController>(
              id: myController.loadingStatus,
              tag: '${RouterManager.webViewId}',
              builder: (controller){
                return Offstage(
                  offstage:  !(controller.isLoading),
                  child: LoadingProgress(),
                );
              }),
        ],
      ),

    );
  }

  /*
  * 导航栏视图
  * */
  _navigationWidget(WebViewZHController controller){
    if(widget.inHomeTab == true){
      return WebViewNavigatorS(
        showLeftBtn: widget.showLeftBtn,
        title: widget.title ?? '',
        progress: controller.progress,
        share: widget.share,
        inHomeTab: widget.inHomeTab,
        canBack: myController.canBack,
        block: (int item){
          _navigationBarClick(item);
        },
      );
    }
    else{
      return WebViewNavigator(
        showLeftBtn: widget.showLeftBtn,
        title: widget.title ?? '',
        progress: controller.progress,
        share: widget.share,
        inHomeTab: widget.inHomeTab,
        canBack: myController.canBack,
        block: (int item){
          _navigationBarClick(item);
        },
      );
    }
  }

  /*
  * 导航栏点击
  * */
  _navigationBarClick(int item)async{
    if(item == 1){//网页返回
      bool canGoBack = await _controller!.canGoBack();
      if(canGoBack) {
        _controller!.goBack();
      }
      else{
        if(widget.inHomeTab == true){
          toast('当前页面已经处于最底端');
        }
        else{
          _backOutPage();
        }
      }
    }
    else if(item == 2){//关闭网页
      _backOutPage();
    }
    else if(item == 3){//分享点击

      if(widget.inHomeTab == true){//跳转到个人中心
        // Get.toNamed(Routers.mine);
      }

    }
    else if(item == 4){//刷新
      _refreshWebView();
    }
  }

  _changeTitle()async{

    String? title = await (_controller!.getTitle());


    if((widget.title?.length ?? 0) ==0 && (title?.length ?? 0) >= 2 && (title?.length ?? 0) < 10){
      widget.title = title;
      myController.updateNav();
    }
    print("------------- changeTitle");
    bool value = await _controller!.canGoBack();
    myController.changeBackStatus(value);

  }



  /*
  * 接收js发送来的方法
  * */
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {

    print("------ js");
    return JavascriptChannel(

        name: 'startFunction',
        onMessageReceived: (JavascriptMessage message) {

          _jsToFlutter(message);

        });

  }


  /*
  * js发送交互到flutter
  * */
  _jsToFlutter(JavascriptMessage message) async {


    print('message == ${message.message}');

    if(message.message.isNotEmpty){

      // Map<String,dynamic> map = message.message;
      // map['phoneNumber'] = phoneNumber;
      // map['code'] = code;
      // map['login'] = login;

      JsParams? jsModel;
      try{
        jsModel = JsParams.fromJson(jsonDecode(message.message));
      }
      catch(e){
         String jsonStr = JsParams.jsonFromErrorJson(message.message);
         jsModel = JsParams.fromJson(jsonDecode(jsonStr));
      }

      if(jsModel.type == '5' && (jsModel.url?.length ?? 0) > 0){//跳转到外部浏览器
        await launchUrlString(jsModel.url ?? '',mode: LaunchMode.externalApplication);
      }
      else if(jsModel.type == '15' && (jsModel.url?.length ?? 0) > 0){//内部H5跳转

      }
      else if(jsModel.type == 'pay'){

        if(jsModel.sign != null){//微信支付
          var result = await Wechat.isWeChatInstalled;
          if(result == true){
            if(jsModel.sign!.data != null){
              _goWeChatPay(jsModel.sign!.data!);
            }
          }
          else{
            showCupertinoDialog(
              context: context,
              builder: (BuildContext c) => AlertAppWidget(title: "请安装微信app", type: 1),
            );
          }
        }
        else if(jsModel.aliSign != null){//支付宝支付
          bool result = await tobias.isAliPayInstalled();
          if(result == true){
            if(jsModel.aliSign!.data != null){
              _goAliPay(jsModel.aliSign!.data!);
            }
          }
          else{
            showCupertinoDialog(
              context: context,
              builder: (BuildContext c) => AlertAppWidget(title: "请安装支付宝App", type: 1),
            );
          }
        }



      }

    }

  }

  /*
  * 唤起支付宝支付
  * */
  _goAliPay(AlipayData data) async {

    Map payResult;
    try {
      tobias.aliPayVersion();
      payResult = await tobias.aliPay(
          data.sign ?? "",
          evn: tobias.AliPayEvn.ONLINE
      );

      _aliPayResult(payResult);

    } on Exception catch (e) {
      payResult = {};
    }

  }

  _aliPayResult(Map payResult){

    debugPrint('==== alipayresult $payResult');

    String resultStatus = payResult["resultStatus"];
    String memo = payResult["memo"] ?? '';

    if(resultStatus == '9000'){
      _goSuccessPage();
    }
    else{
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "支付失败", type: 1),
      );
    }

  }


  /*
  * 前往微信app支付
  * */
  _goWeChatPay(WechatData data) async {

    print("===fwfw  ${data.toJson()}  link ${data.sign?.link}");

    //注册微信支付
    await Wechat.registerWxApi(
        appId: data.sign?.appid ?? "",//  wx8db98029a42e7370
        doOnAndroid: false,
        doOnIOS: true,
        universalLink: "https://amshf.ituiuu.cn");//

    await Wechat.payWithWeChat(
        appId: data.sign?.appid ?? "",
        partnerId: data.sign?.partnerid ?? "",
        prepayId: data.sign?.prepayid ?? "",
        packageValue: 'Sign=WXPay',
        nonceStr: data.sign?.noncestr ?? "",
        timeStamp: int.parse(data.sign?.timestamp ?? '0'),
        sign: data.sign?.signPay ?? ""
    );

  }

  _addWechatHandler(){

    Wechat.weChatResponseEventHandler.listen((res) {

      if (res is Wechat.WeChatPaymentResponse) {
        if(res.isSuccessful == true){
          _goSuccessPage();
        }
        else if(res.errCode == -2){
          showCupertinoDialog(
            context: context,
            builder: (BuildContext c) => AlertAppWidget(title: "取消支付", type: 1),
          );
        }
        else{
          showCupertinoDialog(
            context: context,
            builder: (BuildContext c) => AlertAppWidget(title: "支付失败", type: 1),
          );
        }
      }

    });
  }

  _goSuccessPage()async{

    // Get.toNamed(Routers.pay_success,arguments: Tuple3(logic.serviceUsers, logic.project, logic.serviceItem));

    showCupertinoDialog(
      context: context,
      builder: (BuildContext c) => AlertAppWidget(title: "支付成功", type: 1),
    );

    if(_controller != null){
      await _controller!.loadUrl(widget.originalWebUrl);
      _controller!.clearCache();
    }

  }



  /*
  * 退出页面
  * */
  _backOutPage(){

    Get.back();

  }

  _refreshWebView() async {
    await _controller!.clearCache();
    if(widget.isSecondTab == true){
      widget.originalWebUrl = RequestInterface.myH5Url();
      await _controller!.loadUrl(widget.originalWebUrl);
    }
    else{
      await _controller!.loadUrl(widget.originalWebUrl);
    }
  }

  /*
  * eventbus监听
  * */
  _eventBusListener(){

    EventBusZH().on(EventBusNameZH.RefreshPhysioPageEventId, (arg) async {
      if(mounted){

        if(_controller != null){
          _refreshWebView();
        }
      }
    });

  }

  _eventBusOff(){
    EventBusZH().off(EventBusNameZH.RefreshPhysioPageEventId);
  }

}