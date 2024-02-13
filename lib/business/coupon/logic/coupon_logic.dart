
import 'package:get/get.dart';
import 'package:massage/business/coupon/model/coupon_request_tool.dart';
import '../../home/models/Coupon.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class CouponLogic extends GetxController {

  List<Coupon> coupon =[];//优惠券列表
  List<Coupon> platformCoupon = [];//平台券
  List<Coupon> shopCoupon = [];//店铺

  final dataNotifyId = 'dataNotifyId';

  CouponLogic({required this.coupon});

  requestCouponList() async {
    for(int i =0;i < coupon.length;i++){
      Coupon c = coupon[i];
      bool get = await CouponRequestTool.instance.hasGetCurrentCoupon(c.id ?? 0);
      c.had = get;
      if('平台券' == c.type){
        platformCoupon.add(c);
      }
      else if('店铺券' == c.type){
        shopCoupon.add(c);
      }
    }
    await Future.delayed(const Duration(milliseconds: 300));
    update([dataNotifyId]);
  }

  /*
  * 领取优惠券
  * */
  getCoupon(Coupon coupon) async {

    print("=== coupon receive");
    await CouponRequestTool.instance.addCoupon(couponId: coupon.id ?? 0);
    coupon.had = true;
    update([dataNotifyId]);

  }

}