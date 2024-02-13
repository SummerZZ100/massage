
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../middle/color_value.dart';


/**
 *  create by zhangxiaosong on 2022/6/14
 *  更多弹框
 */

/*
* 回调方法
* type 1：取消  2：确定
* */
typedef LogOffAlertWidgetBlock = Function(int type);

class LogOffAlertWidget extends StatefulWidget {

  String title;
  int type;// 1: 只有确定按钮  2:确定/取消按钮
  LogOffAlertWidgetBlock? block;

  LogOffAlertWidget({Key? key, this.block,required this.title,required this.type}) : super(key: key);

  @override
  State<LogOffAlertWidget> createState() => _LogOffAlertWidgetState();

}

class _LogOffAlertWidgetState extends State<LogOffAlertWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double widgetWidth = ScreenUtil().screenWidth - 100.w;
    double widgetHeight = 280.r;

    return Material(//创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center( //保证控件居中效果
        child: SizedBox(
            width: widgetWidth,
            height: widgetHeight,
            child: Stack(
              children: [
                Image.asset(
                  "${SystemConfig.resource}alert_bg.png",
                  width: widgetWidth,
                  height: widgetHeight,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: widgetWidth,
                  height: widgetHeight,
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: 10.r,right: 10.r,top: 85.r,bottom: 15.r),
                  child: Column(
                    children: [
                      Expanded(child:
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorValue.textColor1(),
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 7,
                      )),
                      SizedBox(height: 8.w,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Offstage(
                            offstage: widget.type == 1,
                            child: TapContainer(
                              childWidget: Container(
                                width: (widgetWidth - 50.r)/2,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                                  color: const Color(0xFFDADADA),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                      color: ColorValue.textColor3(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp
                                  ),
                                ),
                              ),
                              clickBlock: (){
                                Navigator.pop(context);
                                if(widget.block != null){
                                  widget.block!(1);
                                }
                              },
                            ),
                          ),
                          Offstage(
                            offstage: widget.type == 1,
                            child: SizedBox(width: 10.w,),
                          ),
                          TapContainer(
                            childWidget: Container(
                              width: (widgetWidth - 50.w)/2,
                              height: 30.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.w)),
                                color: ColorValue.blueColor(),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '确定',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp
                                ),
                              ),
                            ),
                            clickBlock: (){
                              Navigator.pop(context);
                              if(widget.block != null){
                                widget.block!(2);
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );

  }

}


