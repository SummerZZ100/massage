import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/select_report_content/logic/select_report_content_logic.dart';
import 'package:massage/business/select_report_content/model/Report_content_model.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../widget/report_content_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SelectReportContentPage extends StatefulWidget {

  const SelectReportContentPage({super.key});

  @override
  State<SelectReportContentPage> createState() => _SelectReportContentPageState();

}

class _SelectReportContentPageState extends State<SelectReportContentPage> {

  late SelectReportContentLogic logic;

  @override
  void initState() {

    super.initState();

    logic = Get.put(SelectReportContentLogic());

  }

  @override
  void dispose() {

    logic.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageNav() as PreferredSizeWidget?,
      body: _bodyWidgets(),
    );

  }

  /*
  * 构建导航栏
  * */
  Widget _pageNav() {

    return CupertinoNavbarIOS(
      middle: const Text(
        '举报动态',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
      ),
      leading: NavBackButtonZH(
        LeftIconType.back,
      ),
      trailing: TapContainer(
        childWidget: Text(
          '  提交  ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: const Color(0xFF333333),
            decoration: TextDecoration.none,
          ),
        ),
        clickBlock: (){
          _commitClick();
        },
      ),
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Stack(
      children: [
        GetBuilder<SelectReportContentLogic>(
          id: logic.dataNotifyId,
          builder: (control){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 15.r,top: 12.r,bottom: 12.r),
                  child: Text(
                    '请选择举报原因',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF999999),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Expanded(child: ListView.builder(
                  itemBuilder: (BuildContext bc,int row){
                    ReportContentModel model = logic.reportContentList[row];
                    return TapContainer(
                      childWidget: ReportContentCell(model: model,),
                      clickBlock: (){
                        logic.changeSelectionStatus(row);
                      },
                    );
                  },
                  itemCount: logic.reportContentList.length,
                ))
              ],
            );
          },
        ),
        GetBuilder<SelectReportContentLogic>(
          id: logic.loadingNotifyId,
          builder: (control){
            return Offstage(
              offstage: !(logic.netLoading),
              child: LoadingProgress(),
            );
          },
        )
      ],
    );

  }

  _commitClick(){
    bool hasSelected = false;
     for(int i = 0;i < logic.reportContentList.length;i++){
       ReportContentModel model = logic.reportContentList[i];
       if(model.selected == true){
         hasSelected = true;
         break;
       }
     }
     if(!hasSelected){
       showCupertinoDialog(
         context: context,
         builder: (BuildContext c) => AlertAppWidget(title: "请选择举报原因", type: 1),
       );
     }
     else{
        logic.requestReport((){
          showCupertinoDialog(
            context: context,
            builder: (BuildContext c) => AlertAppWidget(title: "举报成功，经过审核后，我们会做相应处理", type: 1,block: (int type){
              _backPage();
            },),
          );
        });
     }
  }

  _backPage(){
    Future.delayed(Duration(milliseconds: 300),(){
      Get.back();
    });
  }


}
