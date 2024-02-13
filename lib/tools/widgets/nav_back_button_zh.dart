import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


/*
* 导航栏返回按钮样式
* */
enum LeftIconType {
  close,//叉退出
  back,//箭头返回
  setting,//设置
  share,//分享
  refresh,//刷新
  myInfo,// 个人主页
}

typedef NavBackButtonZHBlock = void Function();

/*
* 导航栏返回按钮
* */
class NavBackButtonZH extends StatelessWidget {


  final LeftIconType type;//导航栏返回按钮样式
  NavBackButtonZHBlock? utBackBlock;//返回按钮点击事件

  Color? leftIconColor;//返回按钮颜色

  NavBackButtonZH(this.type, {Key? key, this.leftIconColor, this.utBackBlock}) : super(key: key){
    leftIconColor ??= const Color.fromARGB(255, 51, 51, 51);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoButton(
      color: Colors.transparent,
        padding: EdgeInsets.only(right: 5.w),
        child: Semantics(
          label: '',
          child: backIcon(),

        ),
        onPressed: (){
          if(utBackBlock != null){
            utBackBlock!();
          }
          else{
            Navigator.pop(context);
          }
        },
    );
  }


  //根据返回按钮类型设置不同图标
  Icon backIcon() {
    if(type == LeftIconType.close){
      return Icon(
        CupertinoIcons.clear_thick,
        color: leftIconColor,
        size: 24.0,
      );
    }
    else if(type == LeftIconType.setting){
      return Icon(
        CupertinoIcons.list_bullet,
        color: leftIconColor,
        size: 24.0,
      );
    }
    else if(type == LeftIconType.share){
      return Icon(
        Icons.share,
        color: leftIconColor,
        size: 24.0,
      );
    }
    else if(type == LeftIconType.refresh){
      return Icon(
        Icons.refresh,
        color: leftIconColor,
        size: 24.0,
      );
    }
    else if(type == LeftIconType.myInfo){
      return Icon(
        Icons.account_circle_outlined,
        color: leftIconColor,
        size: 24.0,
      );
    }
    else{
      return Icon(
        CupertinoIcons.back,
        color: leftIconColor,
        size: 24.0,
      );
    }
  }



}
