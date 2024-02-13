import 'package:flutter/cupertino.dart';

/**
 *  create by zhangxiaosong on 9/17/21
 *  describtion
 */

class CupertinoDialogTool {

  //工厂模式
  static CupertinoDialogTool? _instance;
  factory CupertinoDialogTool() => _getInstance()!;
  static CupertinoDialogTool? get instance => _getInstance();

  static CupertinoDialogTool? _getInstance(){
    _instance ??= CupertinoDialogTool._privateConstructor();
    return _instance;
  }

  CupertinoDialogTool._privateConstructor();

  /*
  * Alert方式展示
  * */
  showAlertDialog({required BuildContext context,required Widget child}){
    showCupertinoDialog(
      context: context,
      builder: (BuildContext c) => child,
    );
  }

  /*
  * Action方式展示
  * */
  showActionSheet({required BuildContext context,required Widget child}){
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext c) => child,
    );
  }

}