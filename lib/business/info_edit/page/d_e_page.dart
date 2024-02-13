import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';

import '../../../middle/event_bus_name_zh.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/util/event_bus_zh.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../../tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/16
///  describtion 

class DEPage extends StatefulWidget {


  const DEPage({super.key});

  @override
  State<DEPage> createState() => _DEPageState();

}

class _DEPageState extends State<DEPage> {

  int type = 1;// 1:昵称  2:签名  3:联系方式
  late TextEditingController editController;//编辑框控制器

  @override
  void initState() {
    super.initState();

    type = Get.arguments;

    editController = TextEditingController();
    editController.text = _nowInfo();

  }

  @override
  void dispose() {

    editController.dispose();
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
      middle: Text(
        _title(),
        style:const TextStyle(
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
        childWidget:const Text(
          " 提交  ",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xFF333333),
            decoration: TextDecoration.none,
          ),
        ),
        clickBlock: (){
          _commitClick();
        },
      ),
    );

  }

  _bodyWidgets(){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.r,right: 15.r,top: 10.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white
          ),
          padding: EdgeInsets.all(10.r),
          child: TextField(
            keyboardType: type == 3 ? TextInputType.number : TextInputType.text,
            keyboardAppearance: Brightness.light,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: _hintText(),
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: const Color(0xFF999999),
              ),
            ),
            cursorColor: Colors.blue,
            cursorWidth: 1.w,
            maxLines: 1,
            controller: editController,
            onChanged: (inputContent) {//编辑框编辑事件回调
              // widget.block(3,inputContent);
            },
          ),
        )
      ],
    );
  }

  _title(){
    String t = '';
    if(type == 1){
      t = '昵称';
    }
    else if(type == 2){
      t = '签名';
    }
    else if(type == 3){
      t = '联系方式';
    }
    return t;
  }

  _hintText(){
    String t = '';
    if(type == 1){
      t = '填写昵称';
    }
    else if(type == 2){
      t = '填写签名';
    }
    else if(type == 3){
      t = '填写联系方式';
    }
    return t;
  }

  _nowInfo(){
    String t = '';
    if(type == 1){
      t = UserDataLocalTool.instance.obtainUserName();
    }
    else if(type == 2){
      t = UserDataLocalTool.instance.obtainSignName();
    }
    else if(type == 3){
      t = UserDataLocalTool.instance.obtainPhone();
    }
    return t;
  }

  _commitClick() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(editController.text.isEmpty){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入${_title()}", type: 1)
      );
    }
    else{
       if(type == 1){
         await UserDataLocalTool.instance.changeUserName(editController.text);
       }
       else if(type == 2){
         await UserDataLocalTool.instance.changeUserSign(editController.text);
       }
       else if(type == 3){
         await UserDataLocalTool.instance.changeUserPhone(editController.text);
       }

       EventBusZH().emit(EventBusNameZH.RefreshEditInfoPageEventId);
       EventBusZH().emit(EventBusNameZH.RefreshMinePageEventId);

       showCupertinoDialog(
           context: context,
           builder: (BuildContext c) => AlertAppWidget(title: "${_title()}更新成功", type: 1,block: (int t){
             _backCurrentPage();
           },)
       );

    }
  }

  _backCurrentPage(){
    Future.delayed(const Duration(milliseconds: 300),(){
      Get.back();
    });
  }

}
