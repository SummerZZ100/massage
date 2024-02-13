import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../models/Projects.dart';

///  create by zhangxiaosong on 2023/9/6
///  describtion 

/*
* type 1:
* */
typedef ProductInfoCellBlock = Function();

class ProductInfoCell extends StatelessWidget {

  Projects project;
  ProductInfoCellBlock block;
  ProductInfoCell({super.key,required this.project,required this.block});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.r,top: 12.r,right: 18.r),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x554985FD),width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        padding: EdgeInsets.all(10.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFA8A8A8),width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                child: ImageWidgetZH(
                  imageUrl: (project.imgSrc?.length ?? 0) > 0 ? project.imgSrc![0] : "",
                  imageWidth: 90.r,
                  imageHeight: 90.r,
                  style: 1,
                  fit:BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.r,),
            Expanded(child: SizedBox(
              height: 90.r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: const Color(0xFF333333),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    project.describe ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: const Color(0xFF787878),
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
                                  fontSize: 14.sp,
                                  color: const Color(0xFFD9031D),
                                ),
                              ),
                              TextSpan(
                                text: '元/次',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  color: const Color(0xFFD9031D),
                                ),
                              ),
                              TextSpan(
                                text: ' | ${project.time}分钟',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFF898989),
                                ),
                              )
                            ]
                        ),
                      ),
                      const Spacer(flex: 1,),
                      TapContainer(
                        childWidget: Container(
                          width: 70.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4.r)),
                              color: Colors.blueAccent
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "立即预约",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        clickBlock: (){
                          block();
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
