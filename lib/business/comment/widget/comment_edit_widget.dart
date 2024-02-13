import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massage/business/order/model/order_model.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';

///  create by zhangxiaosong on 2023/9/14
///  describtion 

typedef CommentEditWidgetBlock = Function(int type,String text);

class CommentEditWidget extends StatelessWidget {

  OrderModel orderModel;
  CommentEditWidgetBlock block;
  XFile? imageFile;

  CommentEditWidget({super.key,required this.orderModel,required this.block,this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageWidgetZH(
                imageUrl: _imageUrl(),
                imageWidth: 70.r,
                imageHeight: 70.r,
                style: 1,
                fit:BoxFit.cover,
                radius: 4.r,
              ),
              SizedBox(width: 14.r,),
              Expanded(child:
              SizedBox(
                height: 70.r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(
                          _itemPStr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: const Color(0xFF333333),
                            decoration: TextDecoration.none,
                          ),
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(
                          orderModel.serviceUser?.nickname ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF333333),
                            decoration: TextDecoration.none,
                          ),
                        ),),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(height: 10.r,),
          TextField(
            keyboardType: TextInputType.text,
            keyboardAppearance: Brightness.light,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '评价内容',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: const Color(0xFF999999),
              ),
            ),
            cursorColor: Colors.blue,
            cursorWidth: 1.w,
            maxLines: 5,
            onChanged: (inputContent) {//编辑框编辑事件回调
              block(0,inputContent);
            },
          ),
          SizedBox(height: 10.r,),
          TapContainer(
            childWidget: imageFile != null ? Image.file(
              File(imageFile!.path),
              width: 60.r,
              height: 60.r,
              fit: BoxFit.cover,
            ) : Image.asset(
                "${SystemConfig.resource}photo_logo.png",
                width: 60.r,
                height: 60.r,
            ),
            clickBlock: (){
              block(1,'');
            },
          )
        ],
      ),
    );
  }

  _imageUrl(){
    String image = '';
    if((orderModel.project?.imgSrc?.length ?? 0)  > 0){
      if(orderModel.project!.imgSrc!.length > (orderModel.serviceItem ?? 0)){
        int item = (orderModel.serviceItem ?? 0).toInt();
        image = orderModel.project!.imgSrc![item];
      }
      else{
        image = orderModel.project!.imgSrc![0];
      }
    }

    return image;
  }

  _itemPStr(){
    String itemS = orderModel.project?.name ?? '';
    int item = (orderModel.serviceItem ?? 0).toInt();
    if((orderModel.project?.services?.length ?? 0) > item){
      itemS = orderModel.project!.services![item];
    }
    return itemS;
  }

}
