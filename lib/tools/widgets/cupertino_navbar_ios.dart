import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 *  create by zhangxiaosong on 9/17/21
 *  describtion
 */


/*
* iOS方式的导航栏统一风格定制
* */
class CupertinoNavbarIOS extends CupertinoNavigationBar {

   const CupertinoNavbarIOS({
    Widget? leading,
    bool automaticallyImplyLeading = true,
    bool automaticallyImplyMiddle = true,
    String? previousPageTitle,
    Widget? middle,
    Widget? trailing,
    Color backgroundColor = Colors.white,
    EdgeInsetsDirectional padding = const EdgeInsetsDirectional.only(start: 5, end: 5,),
    Border border = const Border(bottom: BorderSide(color: Colors.transparent)),//设置底部线条为透明
    Color? actionsForegroundColor,
    bool transitionBetweenRoutes = true,
  }) : super(
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    automaticallyImplyMiddle: automaticallyImplyMiddle,
    previousPageTitle: previousPageTitle,
    middle: middle,
    trailing: trailing,
    backgroundColor: backgroundColor,
    padding: padding,
    border: border,
    transitionBetweenRoutes: transitionBetweenRoutes,
  );
}