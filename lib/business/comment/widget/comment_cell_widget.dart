
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../model/comment_model.dart';

class CommentCellWidget extends StatelessWidget {

  CommentModel model;

  CommentCellWidget({super.key,required this.model});

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
                imageWidth: 50.r,
                imageHeight: 50.r,
                style: 1,
                fit:BoxFit.cover,
                radius: 4.r,
              ),
              SizedBox(width: 14.r,),
              Expanded(child:
              SizedBox(
                height: 50.r,
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
                          model.orderModel?.serviceUser?.nickname ?? '',
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
          Text(
            '评价：${model.comment ?? ""}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }

  _imageUrl(){
    String image = '';
    if((model.orderModel?.project?.imgSrc?.length ?? 0)  > 0){
      if(model.orderModel!.project!.imgSrc!.length > (model.orderModel?.serviceItem ?? 0)){
        int item = (model.orderModel?.serviceItem ?? 0).toInt();
        image = model.orderModel!.project!.imgSrc![item];
      }
      else{
        image = model.orderModel!.project!.imgSrc![0];
      }
    }

    return image;
  }

  _itemPStr(){
    String itemS = model.orderModel?.project?.name ?? '';
    int item = (model.orderModel?.serviceItem ?? 0).toInt();
    if((model.orderModel?.project?.services?.length ?? 0) > item){
      itemS = model.orderModel!.project!.services![item];
    }
    return itemS;
  }

}
