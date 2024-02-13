import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  登录 / 验证码录入视图


/*
* 回调方法
* type 1: 重新发送  2：输入验证码
* */
typedef CodeEditViewBlock = Function(int type,String code);


class CodeEditView extends StatefulWidget {

  int countDown;
  CodeEditViewBlock? block;

  CodeEditView({Key? key,required this.countDown,this.block}) : super(key: key);

  @override
  State<CodeEditView> createState() => _CodeEditViewState();

}

class _CodeEditViewState extends State<CodeEditView> {

  TextEditingController editingController = TextEditingController();//编辑框控制器

  @override
  void dispose() {
    // TODO: implement dispose
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 25.r),
      child: Center(
        child: Container(
          width: ScreenUtil().screenWidth - 60.r,
          height: 50.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: const Color(0xFFF4F4F4),
          ),
          padding: EdgeInsets.only(left: 10.r),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: TextField(
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.light,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: ColorValue.textColor1(),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入验证码',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: const Color(0xFF5A5A5A),
                  ),
                ),
                cursorColor: Colors.blue,
                cursorWidth: 1.w,
                maxLines: 1,
                controller: editingController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(6)
                ],
                onChanged: (inputContent) {//编辑框编辑事件回调
                  if (widget.block != null) {
                    widget.block!(2,inputContent);
                  }
                },
              )),
              _countDownWidget()
            ],
          ),
        ),
      ),
    );
  }

  /*
  * 倒计时视图
  * */
  _countDownWidget(){
    if(widget.countDown <= 0){
       return TapContainer(
         childWidget: Container(
           width: 125.r,
           height: 50.r,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r)),
             color: ColorValue.blueColor(),
           ),
           alignment: Alignment.center,
           child: Text(
             '获取验证码',
             style: TextStyle(
               fontWeight: FontWeight.w500,
               color: Colors.white,
               fontSize: 18.sp,
             ),
           ),
         ),
         clickBlock: (){
           if(widget.block != null){
             widget.block!(1,'');
           }
         },
       );
    }
    else{
      return Container(
        width: 125.r,
        height: 50.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r)),
          color: ColorValue.blueColor(),
        ),
        alignment: Alignment.center,
        child: Text(
          '${widget.countDown}s',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      );

    }
  }

}



