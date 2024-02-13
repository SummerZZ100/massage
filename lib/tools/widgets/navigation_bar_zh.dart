import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  导航栏


class NavigationBarZH extends StatelessWidget {

  Widget? leading;
  Widget? middle;
  Widget? trailing;
  Color? backgroundColor;

  NavigationBarZH({Key? key,this.leading,this.middle,this.trailing,this.backgroundColor}) : super(key: key){
    leading ??= const SizedBox();
    middle ??= const SizedBox();
    trailing ??= const SizedBox();
    backgroundColor ??= Colors.white;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 44 + ScreenUtil().statusBarHeight,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      color: backgroundColor,
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            leading!,
            Expanded(child: middle!),
            trailing!
          ],
        ),
      ),
    );
  }
}

