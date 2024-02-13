
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:massage/business/create_order/logic/create_order_logic.dart';
import 'package:massage/business/create_order/model/AlipayData.dart';
import 'package:massage/business/create_order/model/WechatData.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:tuple/tuple.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../../tools/widgets/tap_container.dart';
import '../model/pay_method_model.dart';
import '../model/wechat_app_params.dart';
import '../widget/create_address_widget.dart';
import '../widget/create_paymethod_widget.dart';
import '../widget/create_project_bottom.dart';
import '../widget/create_project_widget.dart';
import '../widget/create_service_widget.dart';
import '../widget/leave_message_widget.dart';
import 'package:fluwx/fluwx.dart' as Wechat;
import 'package:tobias/tobias.dart' as tobias;


///  create by zhangxiaosong on 2023/9/9
///  describtion 

class CreateOrderPage extends StatefulWidget {

  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {

  late CreateOrderLogic logic;

  @override
  void initState() {
    super.initState();

    Tuple4 tuple4 = Get.arguments;
    logic = Get.put(CreateOrderLogic(project: tuple4.item1,serviceUsers: tuple4.item2,
    serviceItem: tuple4.item3,number: tuple4.item4));

    _addWechatHandler();

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
      middle:const Text(
        '提交订单',
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

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TapContainer(
                childWidget: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GetBuilder<CreateOrderLogic>(
                      //   id: logic.contactNotifyId,
                      //   builder: (control){
                      //     return CreateAddressWidget(
                      //       address: logic.address,
                      //       detailAddress: logic.detailAddress,
                      //       contactName: logic.contactName,
                      //       contactPhone: logic.contactPhone,
                      //       sex: logic.sex,
                      //       block: (int type,String text){
                      //         _contactWidgetClick(type,text);
                      //       },
                      //     );
                      //   },
                      // ),
                      GetBuilder<CreateOrderLogic>(
                        id: logic.serviceNotifyId,
                        builder: (control){
                          return CreateServiceWidget(
                            serviceTime: logic.serviceTime,
                            name: logic.serviceUsers.nickname ?? "",
                            projectName: logic.project.name ?? "",
                            headerUrl: logic.serviceUsers.headSrc ?? "",
                            block: (){
                              _showTimePicker();
                            },
                          );
                        },
                      ),
                      GetBuilder<CreateOrderLogic>(
                        id: logic.numNotifyId,
                        builder: (control){
                          return CreateProjectWidget(
                            project: logic.project,
                            serviceItem: logic.serviceItem,
                            number: logic.number,
                            block: (int num){
                              _orderNumberClick(num);
                            },
                          );
                        },
                      ),
                      // LeaveMessageWidget(
                      //   block: (String text){
                      //
                      //   },
                      // ),
                      GetBuilder<CreateOrderLogic>(
                        id: logic.payMethodNotifyId,
                        builder: (control){
                          return CreatePaymethodWidget(
                            payType: logic.payType,
                            block: (int type){
                              logic.changePayMethod(type);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                clickBlock: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
            GetBuilder<CreateOrderLogic>(
              id: logic.bottomNotifyId,
              builder: (control){
                return CreateProjectBottom(
                  project: logic.project,
                  number: logic.number,
                  block: (){
                    _bookClick();
                  },
                );
              },
            )

          ],
        ),
        GetBuilder<CreateOrderLogic>(
          id: logic.loadingNotifyId,
          builder: (control){
            return Offstage(
              offstage: !(logic.netLoading),
              child: LoadingProgress(),
            );
          },
        )
      ],
    );


  }

  /*
  * type 1:服务地址  2:门牌号  3:联系人姓名  4:联系电话  5: 先生/女士  6:通讯录
  * */
  _contactWidgetClick(int type,String text){
    if(type == 1){
      logic.changeAddress(text);
    }
    else if(type == 2){
      logic.changeDetailAddress(text);
    }
    else if(type == 3){
      logic.changeContactName(text);
    }
    else if(type == 4){
       logic.changePhone(text);
    }
    else if(type == 5){
      logic.changeSex(text);
    }
    else if(type == 6){
      Get.toNamed(Routers.address_list,arguments: 1)?.then((value) {
        if(value != null){
          logic.changeCA(value);
        }
      });
    }
  }

  _orderNumberClick(int num){
    logic.changeNumber(num);
  }


  /*
  * 展示出生日期选择框
  * */
  _showTimePicker() {

    DateTime nowDate = DateTime.now();
    DateTime minDate = nowDate.add(const Duration(seconds: 3600));
    DateTime maxDate = nowDate.add(const Duration(days: 7));

    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: minDate,
      maxTime: maxDate,
      // theme: DatePickerTheme(
      //     headerColor: Colors.white,
      //     backgroundColor: Colors.white,
      //     itemStyle: TextStyle(
      //         color: ColorValue.blueColor(), fontWeight: FontWeight.normal, fontSize: 18),
      //     doneStyle: TextStyle(color: ColorValue.blueColor(), fontSize: 16)),
      locale: LocaleType.zh,
      onConfirm:(DateTime dateTime){
        logic.changeServiceTime(dateTime);
      },
    );

  }

  _bookClick() async {

    if(_canCommit()){

      if(logic.payType == 1){//支付宝支付
        bool result = await tobias.isAliPayInstalled();
        if(result == true){
          logic.requestCreateOrder(
              success: (AlipayData data){
                _goAliPay(data);
              },
              fail: (String alert){
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext c) => AlertAppWidget(title: alert, type: 1),
                );
              }
          );
        }
        else{
          showCupertinoDialog(
            context: context,
            builder: (BuildContext c) => AlertAppWidget(title: "请安装支付宝App", type: 1),
          );
        }

      }
      else if(logic.payType == 2){//微信支付
        var result = await Wechat.isWeChatInstalled;
        if(result == true){
          logic.requestCreateOrder(
            success: (WechatData data){
              _goWeChatPay(data);
            },
            fail: (String alert){
              showCupertinoDialog(
                context: context,
                builder: (BuildContext c) => AlertAppWidget(title: alert, type: 1),
              );
            }
          );
        }
        else{
          showCupertinoDialog(
            context: context,
            builder: (BuildContext c) => AlertAppWidget(title: "请安装微信app", type: 1),
          );
        }
      }

    }
  }

  _backHome(){
    Future.delayed(const Duration(milliseconds: 500),(){
      Get.offNamedUntil(Routers.main, (route) => false);
      // Get.offAllNamed(Routers.main);
    });
  }

  _canCommit(){
    return true;
    bool can = true;
    if(logic.address.isEmpty){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入服务地址", type: 1),
      );
      can = false;
    }
    else if(logic.detailAddress.isEmpty){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入详细地址", type: 1),
      );
      can = false;
    }
    else if(logic.contactName.isEmpty){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入联系人姓名", type: 1),
      );
      can = false;
    }
    else if(logic.contactPhone.isEmpty){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入联系电话", type: 1),
      );
      can = false;
    }
    else if(logic.serviceTime == null){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请选择服务时间", type: 1),
      );
      can = false;
    }

    return can;
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

  /*
  * 前往微信app支付
  * */
  _goWeChatPay(WechatData data) async {

    //注册微信支付
    await Wechat.registerWxApi(
        appId: data.sign?.appid ?? "",//  wx8db98029a42e7370
        doOnAndroid: false,
        doOnIOS: true,
        universalLink: data.sign?.link ?? "https://amshf.ituiuu.cn");//https://amshf.ituiuu.cn

    await Wechat.payWithWeChat(
        appId: data.sign?.appid ?? "",
        partnerId: data.sign?.partnerid ?? "",
        prepayId: data.sign?.prepayid ?? "",
        packageValue: 'Sign=WXPay',
        nonceStr: data.sign?.noncestr ?? "",
        timeStamp: int.parse(data.sign?.timestamp ?? '0'),
        sign: data.sign?.signPay ?? ""
    ).then((value) => (value){

    });

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

  _goSuccessPage(){

    Get.toNamed(Routers.pay_success,arguments: Tuple3(logic.serviceUsers, logic.project, logic.serviceItem));

  }


}
