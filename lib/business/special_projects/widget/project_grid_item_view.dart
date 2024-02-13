import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 


class ProjectGridItemView extends StatelessWidget {

  Projects project;
  ProjectGridItemView({super.key,required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),
            child: ImageWidgetZH(
              imageUrl: (project.imgSrc?.length ?? 0) > 0 ? project.imgSrc![0] : "",
              imageWidth: (ScreenUtil().screenWidth - 45.r)/2,
              imageHeight: ((ScreenUtil().screenWidth - 45.r)/2) *135/163,
              style: 1,
              fit:BoxFit.cover,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 4.r,top: 4.r),
          child: Text(
            project.name ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),),
          Padding(padding: EdgeInsets.only(left: 4.r,top: 4.r,bottom: 6.r),
          child: Text.rich(
            TextSpan(
                children: [
                  TextSpan(
                    text: '${project.price}元/次',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFFD9031D),
                    ),
                  ),
                  TextSpan(
                    text: ' ${project.oldPrice} ',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF787878),
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                ]
            ),
          ),)
        ],
      ),
    );
  }
}
