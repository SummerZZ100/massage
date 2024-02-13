import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mine_little_item_widget.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

/*
* 回调方法 type 1:优惠券  2:地址管理   3:我的评价   4:在线客服   5:隐私政策   6:设置
* */
typedef MineControlWidgetBlock = Function(int type);

class MineControlWidget extends StatelessWidget {

  MineControlWidgetBlock block;
  MineControlWidget({super.key,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 15.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        children: [
          Wrap(
            spacing: 30.r,
            runSpacing: 20.r,
            children: [
              MineLittleItemWidget(
                title: '优惠券',
                block: (){
                  block(1);
                },
              ),
              MineLittleItemWidget(
                title: '地址管理',
                block: (){
                  block(2);
                },
              ),
              MineLittleItemWidget(
                title: '我的评价',
                block: (){
                  block(3);
                },
              ),
              MineLittleItemWidget(
                title: '在线客服',
                block: (){
                  block(4);
                },
              ),
              MineLittleItemWidget(
                title: '隐私政策',
                block: (){
                  block(5);
                },
              ),
              MineLittleItemWidget(
                title: '设置',
                block: (){
                  block(6);
                },
              ),

            ],
          ),
        ],
      ),
    );
  }

}
