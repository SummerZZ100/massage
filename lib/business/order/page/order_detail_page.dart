import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/order/model/order_model.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/router_manager.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../logic/orer_detail_logic.dart';
import '../widget/order_address_widget.dart';
import '../widget/order_control_widget.dart';
import '../widget/order_detail_order_widget.dart';
import '../widget/order_detail_project_widget.dart';
import '../widget/order_pay_widget.dart';
import '../widget/order_status_widget.dart';

///  describtion

class OrderDetailPage extends StatefulWidget {

  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();

}

class _OrderDetailPageState extends State<OrderDetailPage>{

  late OrderDetailLogic logic;

  @override
  void initState() {
    super.initState();

    OrderModel model = Get.arguments;
    logic = Get.put(OrderDetailLogic(orderModel: model));

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
      middle: const Text(
        '我的订单',
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
        GetBuilder<OrderDetailLogic>(
          id: logic.dataNotifyId,
            builder: (controller){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    OrderStatusWidget(status: logic.orderModel.orderStatus ?? '',),
                    OrderAddressWidget(orderModel: logic.orderModel,),
                    OrderDetailProjectWidget(model: logic.orderModel,),
                    OrderPayWidget(orderModel: logic.orderModel,),
                    OrderDetailOrderWidget(orderModel: logic.orderModel,),
                    Padding(
                      padding: EdgeInsets.only(top: 10.r,right: 10.r),
                      child: OrderControlWidget(orderModel: logic.orderModel,
                        block: (int cId){
                          _orderControlClick(cId);
                        },),
                    ),
                  ],
                ),
              );
            }),
        GetBuilder<OrderDetailLogic>(
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

  _orderControlClick(int cId){
    if(cId == 1){//取消
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "您确定要取消当前订单？", type: 2,block: (int type)async{
          if(type == 2){
             await logic.cancelOrder();
             EventBusZH().emit(EventBusNameZH.RefreshOrderListPageEventId);
          }
        },),
      );
    }
    else if(cId == 2){//评价
      Get.toNamed(Routers.comment_edit,arguments: logic.orderModel);
    }
    else if(cId == 3){//删除
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "您确定要删除当前订单？", type: 2,block: (int type)async{
          if(type == 2){
            await logic.deleteOrder();
            EventBusZH().emit(EventBusNameZH.RefreshOrderListPageEventId);
            _backPage();
          }
        },),
      );
    }
  }

  _backPage(){
    Future.delayed(const Duration(milliseconds: 300),(){
      Get.back();
    });
  }


}
