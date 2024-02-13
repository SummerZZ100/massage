
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

/**
 *  历史搜索
 */

/*
* 回调方法
* type 1: 搜索 title     2：清空搜索记录
* */
typedef SearchHistoryCellBlock = Function(int type,String title);

class SearchHistoryCell extends StatelessWidget {

  List<String> list;

  SearchHistoryCellBlock block;

  SearchHistoryCell({required this.list,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w,right: 15.w),
      child: Column(
        children: [
          _titleWidget(),
          _itemsWidget(),
        ],
      ),
    );
  }

  /*
  * 标题
  * */
  _titleWidget(){

    return Container(
      padding: EdgeInsets.only(top: 30.w,bottom: 8.w),
      child: Row(
        children: [
           Expanded(child: Text(
               '历史搜索',
               style: TextStyle(
                 fontSize: 15.sp,
                 fontWeight: FontWeight.w500,
                 color: const Color(0xFF333333),
               )
           )),
          TapContainer(
            childWidget: Padding(
              padding: EdgeInsets.only(left: 5.w,right: 2.w,top: 2.w,bottom: 2.w),
              child: Image.asset(
                "${SystemConfig.resource}search_history_clear.png"
              ),
            ),
            clickBlock: (){
              block(2,'');
            },
          ),
        ],
      ),
    );

  }

  /*
  * 标签
  * */
  _itemsWidget(){
    return Container(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 10.w,
        children: _wrapWidgets(),
      ),

    );
  }

  _wrapWidgets(){

    List<Widget> widgets = [];

    for(int i = 0;i < list.length;i++){
      String label = list[i];
      widgets.add(
        TapContainer(
          childWidget: Chip(
          label: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF464646),
              )
          ),
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(left: 8.w,right: 8.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
          clickBlock: (){

            block(1,label);

          },
        )
      );

    }

    return widgets;
  }

}


