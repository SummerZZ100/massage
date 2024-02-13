import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massage/business/info_edit/widget/info_edit_cell.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/event_bus_name_zh.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/util/photo_tool.dart';
import '../../../tools/widgets/cupertino_dialog_tool.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../logic/info_edit_logic.dart';
import '../widget/header_edit_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class InfoEditPage extends StatefulWidget {

  const InfoEditPage({super.key});

  @override
  State<InfoEditPage> createState() => _InfoEditPageState();

}

class _InfoEditPageState extends State<InfoEditPage> {

  late InfoEditLogic logic;

  @override
  void initState() {
    super.initState();

    logic = Get.put(InfoEditLogic());
    _addEventBusListener();
  }

  @override
  void dispose() {

    logic.dispose();
    _removeEventBusListener();
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
        '编辑信息',
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
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.r,right: 15.r,top: 12.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    GetBuilder<InfoEditLogic>(
                      id: logic.headerNotifyId,
                      builder: (control){
                        return TapContainer(childWidget: HeaderEditCell(),
                        clickBlock: (){
                          _selectPicture();
                        },);
                      },
                    ),
                    GetBuilder<InfoEditLogic>(
                      id: logic.dataNotifyId,
                      builder: (control){
                        return TapContainer(
                          childWidget: InfoEditCell(title: "昵称", detail: UserDataLocalTool.instance.obtainUserName()),
                          clickBlock: (){
                             Get.toNamed(Routers.de_page,arguments: 1);
                          },
                        );
                      },
                    ),
                    GetBuilder<InfoEditLogic>(
                      id: logic.dataNotifyId,
                      builder: (control){
                        return TapContainer(childWidget: InfoEditCell(title: "签名", detail: UserDataLocalTool.instance.obtainSignName()),
                        clickBlock: (){
                          Get.toNamed(Routers.de_page,arguments: 2);
                        },);
                      },
                    ),
                    GetBuilder<InfoEditLogic>(
                      id: logic.dataNotifyId,
                      builder: (control){
                        return TapContainer(childWidget: InfoEditCell(title: "性别", detail: UserDataLocalTool.instance.obtainSex()),
                        clickBlock: (){
                          _selectSexAction();
                        },);
                      },
                    ),
                    GetBuilder<InfoEditLogic>(
                      id: logic.dataNotifyId,
                      builder: (control){
                        return TapContainer(childWidget: InfoEditCell(title: "年龄", detail: UserDataLocalTool.instance.obtainAge()),
                        clickBlock: (){
                          _showBirthdayPicker();
                        },);
                      },
                    ),
                    GetBuilder<InfoEditLogic>(
                      id: logic.dataNotifyId,
                      builder: (control){
                        return TapContainer(childWidget: InfoEditCell(title: "联系方式", detail: UserDataLocalTool.instance.obtainPhone()),
                        clickBlock: (){
                          Get.toNamed(Routers.de_page,arguments: 3);
                        },);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        GetBuilder<InfoEditLogic>(
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

  _selectPicture(){

    List<Widget> actions = [];
    String alertTitle = '';

    alertTitle = '请选择图片';

    actions.add(CupertinoActionSheetAction(
      child: const Text('从相册选择'),
      onPressed: () {
        Navigator.pop(context);
        _selectPhoto(0);
      },
    ));
    actions.add(CupertinoActionSheetAction(
      child: const Text('拍摄'),
      onPressed: () {
        Navigator.pop(context);
        _selectPhoto(1);
      },
    ));

    CupertinoDialogTool().showActionSheet(
        context: context,
        child: CupertinoActionSheet(
          title: Text(alertTitle),
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
        ));

  }

  _selectPhoto(int gallery) async{
    XFile? file = await PhotoTool().showImagePicker(gallery);
    if(file != null){
      Uint8List bytes =await file.readAsBytes();
      logic.changePhoto(bytes.toList());
    }
  }

  _selectSexAction(){
    List<Widget> actions = [];
    String alertTitle = '';

    alertTitle = '请选择性别';

    actions.add(CupertinoActionSheetAction(
      child: const Text('男生'),
      onPressed: () {
        Navigator.pop(context);
        logic.changeSex(1);
      },
    ));
    actions.add(CupertinoActionSheetAction(
      child: const Text('女生'),
      onPressed: () {
        Navigator.pop(context);
        logic.changeSex(2);
      },
    ));

    CupertinoDialogTool().showActionSheet(
        context: context,
        child: CupertinoActionSheet(
          title: Text(alertTitle),
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
        ));

  }

  /*
  * 展示出生日期选择框
  * */
  _showBirthdayPicker() {

    DateTime nowDate = DateTime.now();
    DateTime minDate = nowDate.subtract(const Duration(days: 36500));
    DateTime maxDate = nowDate;

    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: minDate,
      maxTime: maxDate,
      // theme: DatePickerThemeData(),
      // theme: DatePickerTheme(
      //     headerColor: Colors.white,
      //     backgroundColor: Colors.white,
      //     itemStyle: TextStyle(
      //         color: ColorValue.blueColor(), fontWeight: FontWeight.normal, fontSize: 18),
      //     doneStyle: TextStyle(color: ColorValue.blueColor(), fontSize: 16)),
      locale: LocaleType.zh,
      onConfirm:(DateTime dateTime){
        logic.changeBirthday(dateTime);
      },
    );


  }

  /*
  * eventbus监听
  * */
  _addEventBusListener(){

    EventBusZH().on(EventBusNameZH.RefreshEditInfoPageEventId, (arg) {
      if(mounted){
        logic.refreshMyInfo();
      }
    });

  }

  _removeEventBusListener(){
    EventBusZH().off(EventBusNameZH.RefreshEditInfoPageEventId);
  }

}
