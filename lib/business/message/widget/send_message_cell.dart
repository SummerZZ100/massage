
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../model/message_model.dart';

/**
 *  发送者聊天视图
 */


class SendMessageCell extends StatefulWidget {

  MessageModel model;

  SendMessageCell({Key? key,required this.model}) : super(key: key);

  @override
  State<SendMessageCell> createState() => _SendMessageCellState();

}

class _SendMessageCellState extends State<SendMessageCell> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(right: 10.w, left: 50.w, top: 10.w, bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "我",
                style: TextStyle(
                    color:const Color(0xFF333333),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
              SizedBox(height: 2.w,),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C81EF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      bottomLeft: Radius.circular(10.w),
                      bottomRight: Radius.circular(10.w),
                  ),
                ),
                child: SelectableText(
                  widget.model.detail ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          )),
          SizedBox(width: 10.w,),
          Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              color: Colors.white
            ),
            alignment: Alignment.center,
            child: Image.asset(
                "${SystemConfig.resource}touxiang.png"
            ),
          ),
        ],
      ),
    );
  }

}


