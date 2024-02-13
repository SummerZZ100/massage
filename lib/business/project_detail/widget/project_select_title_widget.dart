import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 


typedef ProjectSelectTitleWidgetBlock = Function();

class ProjectSelectTitleWidget extends StatelessWidget {

  Projects project;
  int serviceItem;
  ProjectSelectTitleWidgetBlock closeBlock;

  ProjectSelectTitleWidget({super.key,required this.serviceItem,required this.project,required this.closeBlock});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 107.r,
      padding: EdgeInsets.only(left: 18.r,top: 12.r,right: 18.r),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageWidgetZH(
                imageUrl: _imageUrl(),
                imageWidth: 80.r,
                imageHeight: 80.r,
                style: 1,
                fit:BoxFit.cover,
                radius: 17.r,
              ),
              SizedBox(width: 10.r,),
              Expanded(child:
              SizedBox(
                  height: 80.r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        '已选：${project.name}|${project.time}分钟',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: const Color(0xFF333333),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        '¥${project.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: const Color(0xFFD81E06),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  )),
              ),
              TapContainer(childWidget: Padding(padding: EdgeInsets.only(left: 8.r,top: 8.r,bottom: 8.r),
                child: Image.asset(
                    "${SystemConfig.resource}project_select_close.png"
                ),),
                clickBlock: (){
                   closeBlock();
                },
              )
            ],
          ),
          const Spacer(flex: 1,),
          const Divider(
            height: 1,
            color: Color(0xFFDADADA),
          ),
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

}
