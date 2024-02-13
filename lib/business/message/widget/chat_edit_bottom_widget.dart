import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/color_value.dart';

///  发送消息

/*
* 回调方法
* */
typedef ChatEditBottomWidgetBlock = Function(String text);

class ChatEditBottomWidget extends StatefulWidget {

  ChatEditBottomWidgetBlock? block;
  ChatEditBottomWidget({Key? key,this.block}) : super(key: key);

  @override
  State<ChatEditBottomWidget> createState() => _ChatEditBottomWidgetState();
}

class _ChatEditBottomWidgetState extends State<ChatEditBottomWidget> {


  final TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 8.w,bottom: _bottomSpacing()),
      color: Colors.white,
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: const Color(0xFFEAEAEA),
        ),
        height: 40.r,
        child: TextField(
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.send,
          maxLines: null,
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: ColorValue.textColor1(),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '请输入发送内容',
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 0),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: ColorValue.textColor3(),
            ),
          ),
          controller: _controller,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(200),
          ],
          onChanged: (value){

          },
          onEditingComplete: (){
            if(widget.block != null){
              widget.block!(_controller.text);
            }
            _controller.text = '';
          },
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  /*
  * 底部空格
  * */
  _bottomSpacing(){

    if(MediaQuery.of(context).padding.bottom > 0){
      return MediaQuery.of(context).padding.bottom;
    }
    return 8.w;

  }

}
