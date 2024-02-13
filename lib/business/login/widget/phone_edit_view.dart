import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';


///  登录 / 手机号录入视图


/*
* 回调方法
* type 1:切换区域  2：编辑手机号
* */
typedef LoginPhoneEditWidgetBlock = Function(int type,String phone);


class PhoneEditView extends StatefulWidget {

  LoginPhoneEditWidgetBlock? block;

  PhoneEditView({Key? key,this.block}) : super(key: key);

  @override
  State<PhoneEditView> createState() => _PhoneEditViewState();

}

class _PhoneEditViewState extends State<PhoneEditView> {

  TextEditingController editingController = TextEditingController();//编辑框控制器

  @override
  void dispose() {
    // TODO: implement dispose
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    editingController.selection = TextSelection.fromPosition(TextPosition(offset: editingController.text.length));

    return Padding(
      padding: EdgeInsets.only(top: 25.r),
      child: Container(
        width: ScreenUtil().screenWidth - 60.w,
        height: 50.r,
        padding: EdgeInsets.only(left: 10.w,right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: const Color(0xFFF4F4F4),
        ),
        alignment: Alignment.center,
        child: TextField(
          keyboardType: TextInputType.number,
          keyboardAppearance: Brightness.light,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: ColorValue.textColor1(),
            fontSize: 18.sp,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '请输入手机号',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF5A5A5A),
              fontSize: 18.sp,
            ),
          ),
          cursorColor: Colors.blue,
          cursorWidth: 1.w,
          maxLines: 1,
          controller: editingController,
          onChanged: (inputContent) {//编辑框编辑事件回调
            setState(() {
              String tempStr = inputContent.replaceAll(' ', '');
              if (tempStr.length > 3 && tempStr.length <= 7) {
                String fragment1 = tempStr.substring(0, 3);
                String fragment2 = tempStr.substring(3, tempStr.length);
                inputContent = '$fragment1 $fragment2';
              } else if (inputContent.length >= 8) {
                String fragment1 = tempStr.substring(0, 3);
                String fragment2 = tempStr.substring(3, tempStr.length);
                String fragment3 = fragment2.substring(0, 4);
                String fragment4 = fragment2.substring(4, fragment2.length);
                inputContent = '$fragment1 $fragment3 $fragment4';
              }
              if (inputContent.length > 13) {
                inputContent = inputContent.substring(0, 13);
              }
              editingController.text = inputContent;

            });

            if (widget.block != null) {
              widget.block!(2,inputContent);
            }
          },
        ),
      ),
    );
  }

}



