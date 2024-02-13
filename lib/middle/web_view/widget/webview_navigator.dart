import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../color_value.dart';

///  create by zhangxiaosong on 2022/3/7
///  web页导航视图

/*
* 回调方法
* item  1 : 网页返回，2：关闭页面  3:分享  4:刷新
* */
typedef WebViewNavigatorBlock = Function(int item);

class WebViewNavigator extends StatelessWidget {

  WebViewNavigatorBlock? block;//回调方法
  int? progress;//加载进度
  String? title;//标题
  Color? navBackgroundColor;//背景色
  bool? share;//是否可分享
  bool? showLeftBtn;//是否展示左侧按钮
  bool? inHomeTab;//是否处于tab首页
  bool? canBack;//是否可返回

  WebViewNavigator({Key? key, this.showLeftBtn,this.title,this.progress,this.share,this.canBack,this.navBackgroundColor,this.inHomeTab,this.block}) : super(key: key){
    title ??= '';
    progress ??= 0;
    navBackgroundColor ??= Colors.white;
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
      color: navBackgroundColor,
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _left_1_button(),
                _left_2_button(),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: ColorValue.textColor1(),
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: ((share == true ? 24 : 48) + 20.w),),
                Offstage(
                  offstage: !(share == true),
                  child: NavBackButtonZH(
                    LeftIconType.share,
                    utBackBlock: (){
                      if(block != null){
                        block!(3);
                      }
                    },
                  ),
                ),
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
      // if(inHomeTab == true){
      //   return  NavigationBackButtonZH(
      //     LeftIconType.back,
      //     leftIconColor: canBack == true ? Color.fromARGB(255, 51, 51, 51) : Color.fromARGB(255, 222, 222, 222),
      //     utBackBlock: (){
      //       if(block != null){
      //         block!(1);
      //       }
      //     },
      //   );
      // }
      // else{
        return  NavBackButtonZH(
          LeftIconType.back,
          utBackBlock: (){
            if(block != null){
              block!(1);
            }
          },
        );
      // }
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
        );
      }
    }
    return SizedBox(width: 24+5.w,);
  }

}


