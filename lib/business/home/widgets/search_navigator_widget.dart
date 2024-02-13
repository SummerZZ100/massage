
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

/*
* 回调方法
* type 2：编辑文字  3: 搜索  4: 获取焦点的状态
* */
typedef SearchNavigatorWidgetBlock = Function(int type,String value,bool focus);


class SearchNavigatorWidget extends StatefulWidget {

  bool autoFocus;
  String searchText;//搜索文字
  SearchNavigatorWidgetBlock block;//回调方法

  /*
  * 构造方法　
  * */
  SearchNavigatorWidget({required this.searchText,required this.block,required this.autoFocus});

  @override
  _SearchNavigatorWidgetState createState() => _SearchNavigatorWidgetState();

}

class _SearchNavigatorWidgetState extends State<SearchNavigatorWidget> {

  FocusNode focusNode = FocusNode();
  TextEditingController editingController = TextEditingController();//编辑框控制器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      widget.block(4,'',focusNode.hasFocus);
    });
    if(widget.autoFocus){
      focusNode.requestFocus();
    }

  }

  @override
  Widget build(BuildContext context) {

    editingController.text = widget.searchText;

    editingController.selection = TextSelection.fromPosition(TextPosition(offset: editingController.text.length));

    return Container(
      height: 40.r,
      margin: EdgeInsets.only(top: 10.r,bottom: 10.r,left: 18.r,right: 18.r),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 10.r,),
          Image.asset(
            "${SystemConfig.resource}search_p.png"
          ),
          SizedBox(width: 10.r,),
          Expanded(
            child: TextField(
              keyboardAppearance: Brightness.light,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: const Color(0xFF333333),
              ),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                contentPadding: const EdgeInsets.only(bottom: 5),
                hintText: '搜索关键词',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF999999),
                ),
              ),
              controller: editingController,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10)
              ],
              cursorWidth: 1.w,
              maxLines: 1,
              onChanged: (inputContent) {//编辑框编辑事件回调

                widget.block(2,inputContent,true);
              },
              onEditingComplete: (){
                focusNode.unfocus();
                widget.block(3,'',false);
              },
            ),
          ),
        ],
      ),
    );
  }

}
