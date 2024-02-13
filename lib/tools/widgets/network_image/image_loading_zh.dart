import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 *  图片加载中...
 */


class ImageLoadingZH extends StatelessWidget {

  String? alertTitle;//提示内容
  double? paddingTop;
  Color? backgroundColor;//背景色

  double? width;
  double? height;

  ImageLoadingZH({Key? key, this.alertTitle,this.paddingTop,this.backgroundColor,this.width,this.height}) : super(key: key){
    backgroundColor ??= Colors.white;

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width ?? 100.w,
      height: height ?? 100.w,
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(
        alertTitle ?? '...',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xff999999),
          fontSize: 15,
          decoration: TextDecoration.none
        ),
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }

}


