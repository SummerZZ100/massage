
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../../tools/widgets/tap_container.dart';
import '../logic/address_edit_logic.dart';
import '../widget/contact_address_edit_widget.dart';
import '../widget/edit_type_widget.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AddressEditPage extends StatefulWidget {

  const AddressEditPage({super.key});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();

}

class _AddressEditPageState extends State<AddressEditPage> {

  late AddressEditLogic logic;

  @override
  void initState() {
    super.initState();

    Tuple2? tuple2 = Get.arguments;
    logic = Get.put(AddressEditLogic(tuple2));

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
        '编辑地址',
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
        TapContainer(
          childWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<AddressEditLogic>(
                  id: logic.caNotifyId,
                  builder: (control){
                    return ContactAddressEditWidget(
                      address: logic.model.city ?? "",
                      detailAddress: logic.model.addressDetail ?? "",
                      contactName: logic.model.contactName ?? '',
                      contactPhone: logic.model.contactPhone ?? '',
                      sex: logic.model.sex ?? '',
                      block: (int type,String text){
                        _contactAddressWidgetClick(type,text);
                      },
                    );
                  },
                ),
                GetBuilder<AddressEditLogic>(
                    id: logic.typeNotifyId,
                    builder: (controller){
                      return EditTypeWidget(
                        type: logic.model.type ?? 0,
                        isDefault: logic.model.isDefault ?? false,
                        block: (int clickID){
                          if(clickID == 1){
                            logic.changeType(1);
                          }
                          else if(clickID == 2){
                            logic.changeType(2);
                          }
                          else if(clickID == 3){
                            logic.changeDefault();
                          }
                        },
                      );
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 140.r,bottom: 40.r),
                  child: TapContainer(
                    childWidget: Container(
                      width: ScreenUtil().screenWidth - 64.r,
                      height: 48.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.r)),
                          color: Colors.blueAccent
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        logic.editType == 1 ? "更新地址" : "添加地址",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    clickBlock: (){
                      _addAddress();
                    },
                  ),
                )
              ],
            ),
          ),
          clickBlock: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        GetBuilder<AddressEditLogic>(
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


  /*
  * type 1:服务地址  2:门牌号  3:联系人姓名  4:联系电话  5: 先生/女士
  * */
  _contactAddressWidgetClick(int type,String text){
    if(type == 1){
      logic.changeAddress(text);
    }
    else if(type == 2){
      logic.changeDetailAddress(text);
    }
    else if(type == 3){
      logic.changeContactName(text);
    }
    else if(type == 4){
      logic.changePhone(text);
    }
    else if(type == 5){
      logic.changeSex(text);
    }
  }

  _addAddress() async{
    if(_canCommit()){
      await logic.requestCAM();

      String alert = '新增地址信息成功';
      if(logic.editType == 1){
        alert = '更新地址信息成功';
      }
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: alert, type: 1,block: (int t){
          _editSuccessBack();
        },),
      );

    }
  }

  _editSuccessBack(){
    Future.delayed(const Duration(milliseconds: 500),(){
      Get.back(result: true);
    });

  }

  _canCommit(){
    bool can = true;
    if((logic.model.contactName?.length ?? 0) == 0){
      can = false;
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入联系人姓名", type: 1),
      );
    }
    else if((logic.model.contactPhone?.length ?? 0) == 0){
      can = false;
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入联系电话", type: 1),
      );
    }
    else if((logic.model.city?.length ?? 0) == 0){
      can = false;
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入省市区信息", type: 1),
      );
    }
    else if((logic.model.addressDetail?.length ?? 0) == 0){
      can = false;
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入详细地址", type: 1),
      );
    }

    return can;
  }

}
