import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/widgets/recommend_user_item_view.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/6
///  describtion 

/*
* type 1:更多  2:单个技师
* */
typedef HomeRecommendSUCellBlock = Function(int type,ServiceUsers? serviceUser);

class HomeRecommendSUCell extends StatelessWidget {

  List<ServiceUsers> recommendServiceUsers;//首页推荐技师列表
  HomeRecommendSUCellBlock block;
  HomeRecommendSUCell({super.key,required this.recommendServiceUsers,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(left: 18.r,right: 18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TapContainer(childWidget: _moreDataView(),
          clickBlock: (){
             block(1,null);
          },),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 8.r,bottom: 8.r),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _usersWidgets(),
            ),
          ),
        ],
      ),
    );
  }

  _moreDataView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '推荐技师',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: const Color(0xFF4985FD),
            decoration: TextDecoration.none,
          ),
        ),
        const Spacer(flex: 1,),
        Text(
          '查看更多 ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: const Color(0xFF636363),
            decoration: TextDecoration.none,
          ),
        ),
        Image.asset(
          "${SystemConfig.resource}arrow_right.png"
        ),
      ],
    );
  }

  _usersWidgets(){
    List<Widget> users = [];

    for(int i = 0;i < recommendServiceUsers.length;i++){
      ServiceUsers u = recommendServiceUsers[i];
      users.add(TapContainer(childWidget: RecommendUserItemView(user: u,),clickBlock: (){
        block(2,u);
      },));
    }

    return users;
  }

}
