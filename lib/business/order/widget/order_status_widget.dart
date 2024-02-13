import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/middle/system_config.dart';

///  create by zhangxiaosong on 2023/9/13
///  describtion 


class OrderStatusWidget extends StatelessWidget {

  String status;
  OrderStatusWidget({super.key,required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          color: ColorValue.blueColor()
      ),
      padding: EdgeInsets.all(18.r),
      child: Row(
        children: [
          Image.asset(
              _imagePath(),
          ),
          SizedBox(width: 15.r,),
          Expanded(child:
          Text(
            _statusDetail(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ))
        ],
      ),
    );
  }

  _imagePath(){
    // /1: 待接单   2: 待服务    3:已完成    4:已取消   5:已退款
    String imageP = '${SystemConfig.resource}order_detail_waite.png';

    if(status == '3' || status == '5'){
      imageP = '${SystemConfig.resource}order_detail_done.png';
    }
    else if(status == '4'){
      imageP = '${SystemConfig.resource}order_detail_cancel.png';
    }

    return imageP;
  }

  _statusDetail(){
    String detail = '';
    if(status == '1'){
      detail = '待接单';
    }
    else if(status == '2'){
      detail = '待服务';
    }
    else if(status == '3'){
      detail = '服务已完成';
    }
    else if(status == '4'){
      detail = '已取消';
    }
    else if(status == '5'){
      detail = '已退款';
    }
    return detail;
  }

}
