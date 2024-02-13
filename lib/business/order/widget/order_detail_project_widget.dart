import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../model/order_model.dart';

///  create by zhangxiaosong on 2023/9/12
///  describtion 

class OrderDetailProjectWidget extends StatelessWidget {

  OrderModel model;
  OrderDetailProjectWidget({super.key,required this.model});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '预计 ${model.serviceTime} 上门服务',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          ),
          SizedBox(height: 10.r,),
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
                        Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                  text: '¥${(model.project?.price ?? 0)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFFD9031D),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(
                          model.serviceUser?.nickname ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF333333),
                            decoration: TextDecoration.none,
                          ),
                        ),),
                        Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                  text: 'X',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                                TextSpan(
                                  text: '${model.number}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF333333),
                                  ),
                                )
                              ]
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ],
      ),
    );

  }

  _imageUrl(){
    String image = '';
    if((model.project?.imgSrc?.length ?? 0)  > 0){
      if(model.project!.imgSrc!.length > (model.serviceItem ?? 0)){
        int item = (model.serviceItem ?? 0).toInt();
        image = model.project!.imgSrc![item];
      }
      else{
        image = model.project!.imgSrc![0];
      }
    }

    return image;
  }

  _itemPStr(){
    String itemS = model.project?.name ?? '';
    int item = (model.serviceItem ?? 0).toInt();
    if((model.project?.services?.length ?? 0) > item){
      itemS = model.project!.services![item];
    }
    return itemS;
  }

}
