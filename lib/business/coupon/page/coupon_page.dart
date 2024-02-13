import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/coupon/logic/coupon_logic.dart';
import 'package:massage/business/home/models/Coupon.dart';
import 'package:get/get.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../widget/coupon_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class CouponPage extends StatefulWidget {

  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();

}

class _CouponPageState extends State<CouponPage> with TickerProviderStateMixin{

  late CouponLogic logic;

  late TabController tabController;//tab
  List tabs = ["平台券", "店铺券"];//tab标题
  List<Widget> pages = [];//tab子页面
  List<Tab> tabViews = [];

  @override
  void initState() {
    super.initState();

    List<Coupon>? list = Get.arguments;
    logic = Get.put(CouponLogic(coupon: list ?? []));
    logic.requestCouponList();
    _initTabController();
  }

  @override
  void dispose() {

    logic.dispose();
    tabController.dispose();
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
        '领券中心',
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

    return GetBuilder<CouponLogic>(
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

      if(i == 0){
        pages.add(
          GetBuilder<CouponLogic>(
              id: logic.dataNotifyId,
              builder: (controller){
                return ListView.builder(
                  itemBuilder: (BuildContext bc,int row){

                    Coupon coupon = logic.platformCoupon[row];
                    return CouponCell(coupon: coupon,
                      block: (){
                        logic.getCoupon(coupon);
                      },);
                  },
                  itemCount: logic.platformCoupon.length,
                );
              })
        );
      }
      else if(i == 1){
        pages.add(
          GetBuilder<CouponLogic>(
              id: logic.dataNotifyId,
              builder: (controller){
                return ListView.builder(
                  itemBuilder: (BuildContext bc,int row){

                    Coupon coupon = logic.shopCoupon[row];
                    return CouponCell(coupon: coupon,block: (){
                      logic.getCoupon(coupon);
                    },);
                  },
                  itemCount: logic.shopCoupon.length,
                );
              })
        );
      }
      else{
        pages.add(Container());
      }

      tabViews.add(Tab(text: '      ${tabs[i]}      '));

    }
  }

}
