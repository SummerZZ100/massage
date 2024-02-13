import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../middle/system_config.dart';

///  create by zhangxiaosong on 2023/9/6
///  describtion 

class CheckMoreTitle extends StatelessWidget {

  const CheckMoreTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 15.r,right: 15.r,top: 4.r,bottom: 4.r),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(flex: 1,),
        Text(
          '查看更多 ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: const Color(0xFF636363),
            decoration: TextDecoration.none,
          ),
        ),
        Image.asset(
            "${SystemConfig.resource}arrow_right.png"
        ),
      ],
    ),);
  }
}
