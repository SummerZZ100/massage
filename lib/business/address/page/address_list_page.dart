import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massage/business/address/logic/address_list_logic.dart';
import 'package:massage/middle/router_manager.dart';
import 'package:tuple/tuple.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../../../tools/widgets/tap_container.dart';
import '../model/Contact_address_model.dart';
import '../widget/address_cell.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class AddressListPage extends StatefulWidget {

  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();

}

class _AddressListPageState extends State<AddressListPage> {

  late AddressListLogic logic;
  int? type;

  @override
  void initState() {
    super.initState();

    type = Get.arguments;
    logic = Get.put(AddressListLogic());
    logic.requestContactAddressList();

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
        '地址管理',
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
        Column(
          children: [
            Expanded(
              child: GetBuilder<AddressListLogic>(
                id: logic.dataNotifyId,
                builder: (control){
                  return ListView.builder(
                    itemBuilder: (BuildContext bc,int row){

                      ContactAddressModel model = logic.list[row];
                      return TapContainer(
                        childWidget: AddressCell(
                          model: model,
                          block: (int type){
                            // 1: 编辑  2:设为默认  3:删除
                            if(type == 1){
                              Get.toNamed(Routers.address_edit,arguments: Tuple2(model, row))?.then((value) {
                                if(value == true){
                                  logic.requestContactAddressList();
                                }
                              });
                            }
                            else if(type == 2){
                               logic.changeCADefault(row);
                            }
                            else if(type == 3){
                              logic.deleteCA(row);
                            }
                          },),
                        clickBlock: (){
                          if(type == 1){
                            Get.back(result: model);
                          }
                        },
                      );

                    },
                    itemCount: logic.list.length,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.r,bottom: 40.r),
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
                    "添加地址",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                clickBlock: (){
                  Get.toNamed(Routers.address_edit)?.then((value) {
                    if(value == true){
                      logic.requestContactAddressList();
                    }
                  });
                },
              ),
            )
          ],
        ),
        GetBuilder<AddressListLogic>(
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



}
