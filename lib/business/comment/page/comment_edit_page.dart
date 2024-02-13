import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massage/business/order/model/order_model.dart';
import 'package:massage/tools/util/photo_tool.dart';
import 'package:massage/tools/widgets/cupertino_dialog_tool.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../middle/widget/alert_app_widget.dart';
import '../../../tools/widgets/cupertino_navbar_ios.dart';
import '../../../tools/widgets/loading_progress.dart';
import '../../../tools/widgets/nav_back_button_zh.dart';
import '../logic/comment_edit_logic.dart';
import '../widget/comment_edit_widget.dart';

///  describtion

class CommentEditPage extends StatefulWidget {

  const CommentEditPage({super.key});

  @override
  State<CommentEditPage> createState() => _CommentEditPageState();

}

class _CommentEditPageState extends State<CommentEditPage> {

  late CommentEditLogic logic;
  late OrderModel orderModel;

  @override
  void initState() {
    super.initState();

    orderModel = Get.arguments;
    logic = Get.put(CommentEditLogic(orderModel: orderModel));

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
        '服务评价',
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

  /*
  * 构建视图
  * */
  Widget _bodyWidgets() {

    return Stack(
      children: [
        GetBuilder<CommentEditLogic>(
          id: logic.dataNotifyId,
          builder: (control){
            return TapContainer(childWidget: SingleChildScrollView(
              child: Column(
                children: [
                  CommentEditWidget(
                    orderModel: orderModel,
                    block: (int type,String text){
                      if(type == 0){
                        logic.changeContent(text);
                      }
                      else if(type == 1){
                        _selectPicture();
                      }

                    },
                    imageFile: logic.imageFile,
                  )
                ],
              ),
            ), clickBlock: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },);
          },
        ),
        GetBuilder<CommentEditLogic>(
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

  _commitClick() async {

    if(logic.content.isEmpty){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "请输入评价内容", type: 1,block: (int type){
        },),
      );
    }
    else{
      await logic.requestCreateComment();
      showCupertinoDialog(
        context: context,
        builder: (BuildContext c) => AlertAppWidget(title: "评价成功，待审核通过后可在该服务下的评论中展示", type: 1,block: (int type){
          _backPage();
        },),
      );
    }

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
    logic.changeImage(file);
  }

  _backPage(){
    Future.delayed(const Duration(milliseconds: 500),(){
      Get.back();
    });
  }

}
