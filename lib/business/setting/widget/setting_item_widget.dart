import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  create by zhangxiaosong on 2023/9/10
///  describtion 

class SettingItemWidget extends StatelessWidget {

  const SettingItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 15.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          Expanded(child: Text(
            "编辑资料",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          )),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF333333),
          )
        ],
      ),
    );
  }
}
