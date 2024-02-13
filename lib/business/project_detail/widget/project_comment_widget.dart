import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';

import '../../home/models/Comments.dart';
import 'comment_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class ProjectCommentWidget extends StatelessWidget {

  Projects project;

  ProjectCommentWidget({super.key,required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 5.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "用户评价（${project.commentNum}）",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(flex: 1,),
              Text(
                "好评率 ${(project.positiveReviewRate ?? 0) * 100}%",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: const Color(0xFFFDC23E),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.r,),
          Wrap(
            spacing: 10.r,
            runSpacing: 10.r,
            children: _commentTags(),
          ),
          ListView(
            children: _commentCells(),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  _commentTags(){
    List<Widget> list = [];

    if((project.commentTags?.length ?? 0) > 0){
      for(int i = 0;i < project.commentTags!.length;i++){
        String tag = project.commentTags![i];
        list.add(
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              color: const Color(0xFFF0F0F0),
            ),
            padding: EdgeInsets.only(left: 10.r,right: 10.r,bottom: 6.r,top: 6.r),
            child: Text(
              tag,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: const Color(0xFF333333),
                decoration: TextDecoration.none,
              ),
            ),
          )
        );

      }
    }

    return list;
  }

  _commentCells(){

    List<Widget> list = [];

    if((project.comments?.length ?? 0) > 0){
      for(int i = 0;i < project.comments!.length;i++){
        Comments comment = project.comments![i];
        list.add(CommentCell(comment: comment,));
      }
    }

    return list;

  }

}
