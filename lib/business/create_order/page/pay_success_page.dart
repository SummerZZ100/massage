import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../middle/router_manager.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../home/models/Projects.dart';
import '../../home/models/ServiceUsers.dart';
import '../widget/create_project_widget.dart';
import '../widget/create_service_widget.dart';
import '../widget/pay_success_bottom.dart';

///  create by zhangxiaosong on 2023/10/11
///  describtion 

class PaySuccessPage extends StatefulWidget {


  const PaySuccessPage({super.key});

  @override
  State<PaySuccessPage> createState() => _PaySuccessPageState();

}

class _PaySuccessPageState extends State<PaySuccessPage> {

  Projects? project;
  ServiceUsers? serviceUsers;
  int? serviceItem;

  @override
  void initState() {
    super.initState();

    Tuple3? tuple3 = Get.arguments;
    if(tuple3 != null){
      serviceUsers = tuple3.item1;
      project = tuple3.item2;
      serviceItem = tuple3.item3;
    }

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

    return const CupertinoNavbarIOS(
      middle: Text(
        '预约成功',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          decoration: TextDecoration.none,
        ),
      ),
      leading: SizedBox(),
    );

  }

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 18.r,right: 0,top: 10.r,bottom: 0.r),
                       child: Text(
                         "预约成功",
                         style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 14.sp,
                           color: Colors.blueAccent,
                           decoration: TextDecoration.none,
                         ),
                       ),),
                    CreateServiceWidget(
                      serviceTime: null,
                      name: serviceUsers?.nickname ?? "",
                      projectName: project?.name ?? "",
                      headerUrl: serviceUsers?.headSrc ?? "",
                      block: (){

                      },
                    ),
                    CreateProjectWidget(
                      project: project ?? Projects(),
                      serviceItem: serviceItem ?? 0,
                      number: 1,
                      block: (int num){

                      },
                    ),
                  ],
                ),
              ),
            ),
            PaySuccessBottom(
              block: (){
                Get.offNamedUntil(Routers.main, (route) => false);
              },
            ),
          ],
        ),
      ],
    );


  }

}
