
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../model/message_model.dart';

/**
 *  接收者聊天视图
 */


class ReceiveMessageCell extends StatefulWidget {

  MessageModel model;

  ReceiveMessageCell({Key? key,required this.model}) : super(key: key);

  @override
  State<ReceiveMessageCell> createState() => _ReceiveMessageCellState();

}

class _ReceiveMessageCellState extends State<ReceiveMessageCell> {

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
      padding: EdgeInsets.only(right: 50.w, left: 10.w, top: 10.w, bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                color: Colors.white
            ),
            alignment: Alignment.center,
            child: Image.asset(
                "${SystemConfig.resource}shop_message.png"
            ),
          ),
          SizedBox(width: 10.w,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "客服",
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.w),
                      bottomLeft: Radius.circular(10.w),
                      bottomRight: Radius.circular(10.w),
                  ),
                ),
                child: SelectableText(
                  widget.model.detail ?? '',
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          )),


        ],
      ),
    );
  }

}


