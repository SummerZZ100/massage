import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 


typedef LeaveMessageWidgetBlock = Function(String text);

class LeaveMessageWidget extends StatelessWidget {

  LeaveMessageWidgetBlock block;
  LeaveMessageWidget({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '留言',
            style: TextStyle(
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
          TextField(
            keyboardType: TextInputType.text,
            keyboardAppearance: Brightness.light,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '给商家捎句话',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: const Color(0xFF999999),
              ),
            ),
            cursorColor: Colors.blue,
            cursorWidth: 1.w,
            maxLines: 1,
            onChanged: (inputContent) {//编辑框编辑事件回调
              block(inputContent);
            },
          )
        ],
      ),
    );
  }
}
