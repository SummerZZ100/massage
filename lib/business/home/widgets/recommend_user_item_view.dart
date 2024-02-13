import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/6
///  describtion 

class RecommendUserItemView extends StatelessWidget {

  ServiceUsers user;
  RecommendUserItemView({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.r),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        child: Container(
          color: Colors.white,
          width: 85.r,
          height: 126.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidgetZH(
                imageUrl: user.headSrc,
                imageWidth: 85.r,
                imageHeight: 85.r,
                style: 1,
                fit:BoxFit.cover,
              ),
              Padding(padding: EdgeInsets.only(left: 6.r,top: 4.r),
              child: Text(
                user.nickname ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
              ),),
              Padding(padding: EdgeInsets.only(left: 6.r),
              child: Text(
                '总接单${user.orderNum ?? 0}+',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: const Color(0xFF787878),
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
