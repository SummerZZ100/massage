import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';

import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/6
///  describtion 

/*
* type 1:
* */
typedef ProductInfoCellBlock = Function();

class ServiceProductInfoCell extends StatelessWidget {

  Projects project;
  ProductInfoCellBlock block;

  ServiceProductInfoCell({super.key,required this.project,required this.block});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.r),
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
                  imageWidth: 70.r,
                  imageHeight: 70.r,
                  style: 1,
                  fit:BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.r,),
            Expanded(child: SizedBox(
              height: 70.r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF333333),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    '${project.time ?? 0}分钟/${project.describe ?? ""}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
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
