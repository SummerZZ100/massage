import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


///  create by zhangxiaosong on 2023/9/16
///  describtion 

class InfoEditCell extends StatelessWidget {

  String title;
  String detail;

  InfoEditCell({super.key,required this.title,required this.detail});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 52.r,
      padding: EdgeInsets.only(left: 16.r,right: 14.r),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(width: 10.r,),
                Expanded(child: Text(
                  _detailStr(),
                  style: TextStyle(
                    color: _detailColor(),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.right,
                )),
                SizedBox(width: 10.r,),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF333333),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFFEAEAEA),
          )
        ],
      ),
    );
  }

  _detailColor(){
    if(detail.isEmpty){
      return const Color(0xFF999999);
    }
    else{
      return const Color(0xFF333333);
    }
  }

  _detailStr(){
    if(detail.isEmpty){
      if(title == '昵称'){
        return '设置昵称';
      }
      else if(title == '签名'){
        return '设置签名';
      }
      else if(title == '性别'){
        return '设置性别';
      }
      else if(title == '年龄'){
        return '选择出生日期';
      }
      else if(title == '联系方式'){
        return '';
      }
    }
    else{
      return detail;
    }
  }

}
