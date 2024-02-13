import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

/*
* 回调方法
* type 1:服务地址  2:门牌号  3:联系人姓名  4:联系电话  5: 先生/女士
* */
typedef ContactAddressEditWidgetBlock = Function(int type,String text);

class ContactAddressEditWidget extends StatefulWidget {

  String address;
  String detailAddress;
  String contactName;
  String contactPhone;
  String sex;
  ContactAddressEditWidgetBlock block;

  ContactAddressEditWidget({super.key,required this.address,required this.detailAddress,required this.contactName,
    required this.contactPhone,required this.sex,required this.block});

  @override
  State<ContactAddressEditWidget> createState() => _ContactAddressEditWidgetState();

}

class _ContactAddressEditWidgetState extends State<ContactAddressEditWidget> {

  TextEditingController addressEditingController = TextEditingController();//编辑框控制器
  TextEditingController detailAddressEC = TextEditingController();//编辑框控制器
  TextEditingController contactNameEC = TextEditingController();//编辑框控制器
  TextEditingController contactPhoneEC = TextEditingController();//编辑框控制器

  @override
  Widget build(BuildContext context) {

    addressEditingController.text = widget.address;
    addressEditingController.selection = TextSelection.fromPosition(TextPosition(offset: addressEditingController.text.length));

    detailAddressEC.text = widget.detailAddress;
    detailAddressEC.selection = TextSelection.fromPosition(TextPosition(offset: detailAddressEC.text.length));

    contactNameEC.text = widget.contactName;
    contactNameEC.selection = TextSelection.fromPosition(TextPosition(offset: contactNameEC.text.length));

    contactPhoneEC.text = widget.contactPhone;
    contactPhoneEC.selection = TextSelection.fromPosition(TextPosition(offset: contactPhoneEC.text.length));

    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80.r,
                padding: EdgeInsets.only(right: 10.r),
                alignment: Alignment.centerLeft,
                child: Text(
                  '联系人',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(child: Column(
                children: [TextField(
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: const Color(0xFF333333),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '联系人姓名',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),
                  cursorColor: Colors.blue,
                  cursorWidth: 1.w,
                  maxLines: 1,
                  controller: contactNameEC,
                  onChanged: (inputContent) {//编辑框编辑事件回调
                    widget.block(3,inputContent);
                  },
                ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFDADADA),
                  ),
                ],
              )),
              Text(
                ' |',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF999999),
                ),
              ),
              TapContainer(
                childWidget: Container(
                  padding: EdgeInsets.only(left: 5.r,right: 5.r),
                  child: Row(
                    children: [
                      Icon(
                        widget.sex == '先生' ? Icons.radio_button_checked : Icons.radio_button_unchecked_outlined,
                        color: widget.sex == '先生' ? const Color(0xFF4985FD) : const Color(0xFF999999),
                        size: 12.r,
                      ),
                      Text(
                        ' 先生',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
                clickBlock: (){
                  widget.block(5,"先生");
                },
              ),
              TapContainer(
                childWidget: Container(
                  padding: EdgeInsets.only(left: 5.r,right: 5.r),
                  child: Row(
                    children: [
                      Icon(
                        widget.sex == '女士' ? Icons.radio_button_checked : Icons.radio_button_unchecked_outlined,
                        color: widget.sex == '女士' ? const Color(0xFF4985FD) : const Color(0xFF999999),
                        size: 12.r,
                      ),
                      Text(
                        ' 女士',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
                clickBlock: (){
                  widget.block(5,"女士");
                },
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 80.r,
                padding: EdgeInsets.only(right: 10.r),
                alignment: Alignment.centerLeft,
                child: Text(
                  '联系电话',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(child: Column(
                children: [TextField(
                  keyboardType: TextInputType.number,
                  keyboardAppearance: Brightness.light,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: const Color(0xFF333333),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '联系人电话',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),
                  cursorColor: Colors.blue,
                  cursorWidth: 1.w,
                  maxLines: 1,
                  controller: contactPhoneEC,
                  onChanged: (inputContent) {//编辑框编辑事件回调
                    widget.block(4,inputContent);
                  },
                ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFDADADA),
                  ),
                ],
              )),
            ],
          ),
           Row(
             children: [
               Container(
                 width: 80.r,
                 padding: EdgeInsets.only(right: 10.r),
                 alignment: Alignment.centerLeft,
                 child: Text(
                   '省市区',
                   style: TextStyle(
                     color: const Color(0xFF333333),
                     fontWeight: FontWeight.w600,
                     fontSize: 15.sp,
                   ),
                 ),
               ),
               Expanded(child: Column(
                 children: [TextField(
                   keyboardType: TextInputType.text,
                   keyboardAppearance: Brightness.light,
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 14.sp,
                     color: const Color(0xFF333333),
                   ),
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: '请输入省/城市/区县/街道',
                     hintStyle: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 14.sp,
                       color: const Color(0xFF999999),
                     ),
                   ),
                   cursorColor: Colors.blue,
                   cursorWidth: 1.w,
                   maxLines: 1,
                   controller: addressEditingController,
                   onChanged: (inputContent) {//编辑框编辑事件回调
                     widget.block(1,inputContent);
                   },
                 ),
                   const Divider(
                     height: 1,
                     color: Color(0xFFDADADA),
                   ),
                 ],
               ))
             ],
           ),
          Row(
            children: [
              Container(
                width: 80.r,
                padding: EdgeInsets.only(right: 10.r),
                alignment: Alignment.centerLeft,
                child: Text(
                  '详细地址',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(child: Column(
                children: [TextField(
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: const Color(0xFF333333),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入小区/单元号/房间号',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),
                  cursorColor: Colors.blue,
                  cursorWidth: 1.w,
                  maxLines: 1,
                  controller: detailAddressEC,
                  onChanged: (inputContent) {//编辑框编辑事件回调
                    widget.block(2,inputContent);
                  },
                ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFDADADA),
                  ),
                ],
              ))
            ],
          ),

        ],
      ),
    );
  }
}
