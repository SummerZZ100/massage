import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../../../tools/widgets/tap_container.dart';
import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 


typedef CreateProjectWidgetBlock = Function(int number);

class CreateProjectWidget extends StatelessWidget {

  Projects project;
  int serviceItem;
  int number;
  CreateProjectWidgetBlock block;

  CreateProjectWidget({super.key,required this.project,required this.serviceItem,
    required this.number,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidgetZH(
            imageUrl: _imageUrl(),
            imageWidth: 70.r,
            imageHeight: 70.r,
            style: 1,
            fit:BoxFit.cover,
          ),
          SizedBox(width: 12.r,),
          Expanded(child: SizedBox(
            height: 70.r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _itemPStr(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: const Color(0xFF333333),
                    decoration: TextDecoration.none,
                  ),
                ),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                              text: '${project.price}',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xFFD9031D),
                              ),
                            ),
                            TextSpan(
                              text: '元/次',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFFD9031D),
                              ),
                            )
                          ]
                      ),
                    ),
                    const Spacer(flex: 1,),
                    // TapContainer(
                    //   childWidget: Container(
                    //     width: 24.r,
                    //     height: 24.r,
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       '-',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 14.sp,
                    //         color:const Color(0xFF333333),
                    //         decoration: TextDecoration.none,
                    //       ),
                    //     ),
                    //   ),
                    //   clickBlock: (){
                    //     if(number > 1){
                    //       number -= 1;
                    //       block(number);
                    //     }
                    //   },
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    //       color: const Color(0xFFEEEEEE)
                    //   ),
                    //   child: Text(
                    //     '  $number  ',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14.sp,
                    //       color: const Color(0xFF646464),
                    //       decoration: TextDecoration.none,
                    //     ),
                    //   ),
                    // ),
                    // TapContainer(
                    //   childWidget: Container(
                    //     width: 24.r,
                    //     height: 24.r,
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       '+',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 14.sp,
                    //         color:const Color(0xFF333333),
                    //         decoration: TextDecoration.none,
                    //       ),
                    //     ),
                    //   ),
                    //   clickBlock: (){
                    //     if(number < 9){
                    //       number += 1;
                    //       block(number);
                    //     }
                    //   },
                    // )
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  _imageUrl(){
    String image = '';
    if((project.imgSrc?.length ?? 0)  > 0){
      if(project.imgSrc!.length > serviceItem){
        image = project.imgSrc![serviceItem];
      }
      else{
        image = project.imgSrc![0];
      }
    }

    return image;
  }

  _itemPStr(){
    String itemS = project.name ?? '';
    if((project.services?.length ?? 0) > serviceItem){
      itemS = project.services![serviceItem];
    }
    return itemS;
  }

}
