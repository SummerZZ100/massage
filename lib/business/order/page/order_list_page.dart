import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/order/logic/orer_list_logic.dart';
import 'package:massage/business/order/model/order_model.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../widget/order_list_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class OrderListPage extends StatefulWidget {

  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();

}

class _OrderListPageState extends State<OrderListPage> with TickerProviderStateMixin{

  late OrderListLogic logic;
  late TabController tabController;//tab
  List tabs = ["全部", "待接单","待服务","已完成","退款/售后"];//tab标题
  List<Widget> pages = [];//tab子页面
  List<Tab> tabViews = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    currentIndex = Get.arguments ?? 0;
    logic = Get.put(OrderListLogic());
    logic.requestOrderList(currentIndex,false);
    _initTabController();

    tabController.index = currentIndex;
    tabController.addListener(() {

      currentIndex = tabController.index;
      logic.requestOrderList(currentIndex,true);

    });

    _addEventBusListener();

  }

  @override
  void dispose() {

    logic.dispose();
    _removeEventBusListener();
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
        GetBuilder<OrderListLogic>(
          id: logic.dataNotifyId,
          builder: (control){
            return Column(
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  height: 44,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.center,
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      labelColor: const Color(0xFF4985FD),
                      unselectedLabelColor: const Color(0xFF333333),
                      indicatorColor: const Color(0xFF4985FD),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF4985FD),
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF333333),
                      ),
                      indicatorWeight: 2.w,
                      tabs: tabViews,
                    ),
                  ),
                ),
                Expanded(child: TabBarView(
                  controller: tabController,
                  children: pages,
                )),
              ],
            );
          },
        ),
        GetBuilder<OrderListLogic>(
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
  * 初始化tab控制器
  * */
  _initTabController(){

    tabController = TabController(length: tabs.length, vsync: this);
    tabController.index = 0;
    tabController.addListener(() {
    });

    for(int i=0;i<tabs.length;i++) {

      pages.add(GetBuilder<OrderListLogic>(
        id: logic.dataNotifyId,
        builder: (controller){
          if(logic.orderList.isNotEmpty){
            return ListView.builder(
              itemBuilder: (BuildContext bc,int row){
                OrderModel model = logic.orderList[row];
                return TapContainer(childWidget: OrderListCell(
                  model: model,
                  block: (int cId){
                    _controlClick(row,cId);
                  },
                ),
                  clickBlock: (){
                    _goDetail(model);
                  },);
              },
              itemCount: logic.orderList.length,
            );
          }
          else{
            return Container(
              alignment: Alignment.center,
              child: Text(
                "暂无订单",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF999999),
                  decoration: TextDecoration.none,
                ),
              ),
            );
          }

        },
      ));

      tabViews.add(Tab(text: '${tabs[i]}'));

    }
  }

  _goDetail(OrderModel orderModel){
    Get.toNamed(Routers.order_detail,arguments: orderModel);
  }

  _controlClick(int row,int cId){
    if(cId == 1){//取消
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "您确定要取消当前订单？", type: 2,block: (int type){
          if(type == 2){
            logic.cancelOrder(row, currentIndex);
          }
        },),
      );

    }
    else if(cId == 2){//去评价
      Get.toNamed(Routers.comment_edit,arguments: logic.orderList[row]);
    }
    else if(cId == 3){//删除订单
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "您确定要删除当前订单？", type: 2,block: (int type){
          if(type == 2){
            logic.deleteOrder(row, currentIndex);
          }
        },),
      );

    }
  }

  /*
  * eventbus监听
  * */
  _addEventBusListener(){
    //
    EventBusZH().on(EventBusNameZH.RefreshOrderListPageEventId, (arg) {
      if(mounted){
        logic.requestOrderList(currentIndex, true);
      }
    });

  }

  _removeEventBusListener(){
    print("===main off");
    EventBusZH().off(EventBusNameZH.RefreshOrderListPageEventId);
  }


}
