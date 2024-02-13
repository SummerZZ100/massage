import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 


typedef CreatePaymethodWidgetBlock = Function(int payType);

class CreatePaymethodWidget extends StatelessWidget {

  int payType;// 1: 支付宝  2:微信
  CreatePaymethodWidgetBlock block;
  CreatePaymethodWidget({super.key,required this.payType,required this.block});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '支付方式',
            style: TextStyle(
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 15.r,),
          Row(
            children: [
              TapContainer(childWidget:
              Container(
                height: 42.r,
                padding: EdgeInsets.only(left: 8.r,right: 8.r),
                decoration: BoxDecoration(
                  border: Border.all(color: payType == 2 ? Colors.blue : Colors.white,width: 1),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                        "${SystemConfig.resource}wexin_pay.png"
                    ),
                    Text(
                      '  微信支付',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),clickBlock: (){
                 block(2);
              },),
              SizedBox(width: 20.r,),
              TapContainer(childWidget: Container(
                height: 42.r,
                padding: EdgeInsets.only(left: 8.r,right: 8.r),
                decoration: BoxDecoration(
                  border: Border.all(color: payType == 1 ? Colors.blue : Colors.white,width: 1),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                        "${SystemConfig.resource}ali_pay.png"
                    ),
                    Text(
                      '   支付宝支付',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),clickBlock: (){
                block(1);
              },)
            ],
          )
        ],
      ),
    );
  }
}
