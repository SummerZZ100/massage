import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/util/common_util_zh.dart';
import '../../../tools/widgets/tap_container.dart';


typedef PaySuccessBottomBlock = Function();

class PaySuccessBottom extends StatelessWidget {

  PaySuccessBottomBlock block;

  PaySuccessBottom({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height:CommonUtilZH().bottomSpacing(context, 10.w) + 10.w + 42.w,
      alignment: Alignment.topCenter,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20.r,right: 20.r,top: 10.r),
      child: TapContainer(
        childWidget: Container(
          width: ScreenUtil().screenWidth - 80.r,
          height: 40.r,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              color: Colors.blueAccent
          ),
          alignment: Alignment.center,
          child: Text(
            "好的",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        clickBlock: (){
          block();
        },
      ),
    );
  }
}
