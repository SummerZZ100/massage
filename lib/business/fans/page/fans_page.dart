import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massage/business/fans/logic/fans_logic.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class FansPage extends StatefulWidget {

  const FansPage({super.key});

  @override
  State<FansPage> createState() => _FansPageState();

}

class _FansPageState extends State<FansPage> {

  late FansLogic logic;

  @override
  void initState() {
    super.initState();

    logic = Get.put(FansLogic());

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
        '粉丝',
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

    return GetBuilder<FansLogic>(
      id: logic.dataNotifyId,
      builder: (control){
        return ListView.builder(
          itemBuilder: (BuildContext bc,int row){

            return Container();
          },
          itemCount: 3,
        );
      },
    );

  }
}
