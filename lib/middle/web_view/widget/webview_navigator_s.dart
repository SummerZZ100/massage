import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../../middle/system_config.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../color_value.dart';

///  create by zhangxiaosong on 2022/3/7
///  web页导航视图

/*
* 回调方法
* item  1 : 网页返回，2：关闭页面  3:分享  4:刷新
* */
typedef WebViewNavigatorSBlock = Function(int item);

class WebViewNavigatorS extends StatelessWidget {

  WebViewNavigatorSBlock? block;//回调方法
  int? progress;//加载进度
  String? title;//标题
  bool? share;//是否可分享
  bool? showLeftBtn;//是否展示左侧按钮
  bool? inHomeTab;//是否处于tab首页
  bool? canBack;//是否可返回

  WebViewNavigatorS({Key? key, this.showLeftBtn,this.title,this.progress,this.share,this.canBack,this.inHomeTab,this.block}) : super(key: key){
    title ??= '';
    progress ??= 0;
    share ??= false;
    showLeftBtn ??= true;
  }

  static double viewHeight(){
    return (44 + ScreenUtil().statusBarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 44 + ScreenUtil().statusBarHeight,
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 15.r,),
                _left_1_button(),
                _left_2_button(),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: ColorValue.textColor1(),
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 72 + 30.r,),
              ],
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: _progressValue(),
            valueColor: AlwaysStoppedAnimation<Color>(ColorValue.blueColor()),
            minHeight: 3.0,
          )

        ],
      ),
    );
  }

  _progressValue(){
    double value = 1.0;
    if(progress! < 90){
      value = progress! / 100;
    }
    else{
      value = 0;
    }
    return value;
  }

  _left_1_button(){

    if(showLeftBtn == true){
        return  NavBackButtonZH(
          LeftIconType.back,
          utBackBlock: (){
            if(block != null){
              block!(1);
            }
          },
          leftIconColor: ColorValue.textColor1(),
        );
    }

    return SizedBox(width: 24+5.w,);

  }

  _left_2_button(){
    if(showLeftBtn == true){
      if(inHomeTab == true){
        return NavBackButtonZH(
          LeftIconType.refresh,
          utBackBlock: (){
            if(block != null){
              block!(4);
            }
          },
          leftIconColor: ColorValue.textColor1(),
        );
      }
      else{
        return NavBackButtonZH(
          LeftIconType.close,
          utBackBlock: (){
            if(block != null){
              block!(2);
            }
          },
          leftIconColor: Colors.white,
        );
      }
    }
    return SizedBox(width: 24+5.w,);
  }

}


