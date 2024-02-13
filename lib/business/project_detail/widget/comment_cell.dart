import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../../home/models/Comments.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 


class CommentCell extends StatelessWidget {

  Comments comment;

  CommentCell({super.key,required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.r,
      padding: EdgeInsets.only(left: 10.r,top: 10.r,right: 10.r),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidgetZH(
                imageUrl: comment.headSrc,
                imageWidth: 34.r,
                imageHeight: 34.r,
                style: 1,
                fit:BoxFit.cover,
                radius: 17.r,
              ),
              SizedBox(width: 10.r,),
              Expanded(child:
              SizedBox(
                  height: 60.r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.nickname ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: const Color(0xFF333333),
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const Spacer(flex: 1,),
                          Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: const Color(0xFF333333),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: _starWidgets(),
                      ),
                      Text(
                        comment.content ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: const Color(0xFF666666),
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  )),
              )
            ],
          ),
          const Spacer(flex: 1,),
          const Divider(
            height: 1,
            color: Color(0xFFDADADA),
          ),
        ],
      ),
    );
  }

  _starWidgets(){
    List<Widget> list = [];

    if((comment.star ?? 0) > 0){
      for(int i = 0;i < comment.star!;i++){
        list.add(Icon(
          Icons.star,
          color: const Color(0xFFD9031D),
          size: 10.r,
        ));
      }
    }

    return list;
  }

}
