/*
@Date: 2020/6/10
@author: zhangxiaosong
@describe 点击手势组件封装
**/

import 'package:flutter/cupertino.dart';


class TapContainer extends StatelessWidget {

  Widget childWidget;//包裹子视图
  Function()? clickBlock;//点击事件

  TapContainer({Key? key, required this.childWidget,this.clickBlock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> _tapClick(),
      behavior: HitTestBehavior.opaque,
      child: childWidget,
    );
  }

  /*
  * 点击事件
  * */
  _tapClick(){
    if(clickBlock != null){
      clickBlock!();
    }
  }
}
