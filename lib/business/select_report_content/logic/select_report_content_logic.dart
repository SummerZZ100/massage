
import 'dart:math';

import 'package:get/get.dart';
import 'package:massage/business/select_report_content/model/Report_content_model.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SelectReportContentLogic extends GetxController {

  List<ReportContentModel> reportContentList = [];
  bool netLoading = false;

  final loadingNotifyId = 'loadingNotifyId';
  final dataNotifyId = 'dataNotifyId';

  SelectReportContentLogic(){
    _initData();
  }

  _initData(){
    reportContentList.add(ReportContentModel(title: '政治敏感',selected: false));
    reportContentList.add(ReportContentModel(title: '违法违规',selected: false));
    reportContentList.add(ReportContentModel(title: '色情低俗',selected: false));
    reportContentList.add(ReportContentModel(title: '诈骗信息',selected: false));
    reportContentList.add(ReportContentModel(title: '广告营销',selected: false));
    reportContentList.add(ReportContentModel(title: '展示假货',selected: false));
    reportContentList.add(ReportContentModel(title: '虚假产品',selected: false));
    reportContentList.add(ReportContentModel(title: '危险行为',selected: false));
    reportContentList.add(ReportContentModel(title: '未成年保护',selected: false));
    reportContentList.add(ReportContentModel(title: '网络暴力',selected: false));
    reportContentList.add(ReportContentModel(title: '引人不适',selected: false));
    reportContentList.add(ReportContentModel(title: '诱导关注点赞',selected: false));
    reportContentList.add(ReportContentModel(title: '疑似自相残杀',selected: false));
  }

  changeSelectionStatus(int item){
    ReportContentModel model = reportContentList[item];
    model.selected = !(model.selected ?? false);
    update([dataNotifyId]);
  }

  requestReport(Function? success) async {

    netLoading = true;
    update([loadingNotifyId]);

    int count = 0;
    while(count == 0){
      count = Random().nextInt(2);
    }

    await Future.delayed(Duration(milliseconds: count*1000));

    netLoading = false;
    if(success != null){
      success();
    }

  }

}