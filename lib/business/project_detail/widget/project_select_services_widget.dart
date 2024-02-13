import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

typedef ProjectSelectServicesWidgetBlock = Function(int item);

class ProjectSelectServicesWidget extends StatelessWidget {

  Projects project;
  int serviceItem;
  ProjectSelectServicesWidgetBlock block;
  ProjectSelectServicesWidget({super.key,required this.project,required this.serviceItem,required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18.r,right: 18.r,top: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "服务项目",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 5.r,),
          Wrap(
            spacing: 10.r,
            runSpacing: 10.r,
            children: _serviceTags(),
          ),
          SizedBox(height: 10.r,),
          const Divider(
            height: 1,
            color: Color(0xFFDADADA),
          ),
        ],
      ),
    );
  }

  _serviceTags(){
    List<Widget> list = [];

    if((project.services?.length ?? 0) > 0){
      for(int i = 0;i < project.services!.length;i++){
        String tag = project.services![i];
        list.add(
            TapContainer(childWidget: Container(
              height: 28.r,
              width: 120.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14.r)),
                  color: serviceItem == i ? const Color(0xFFFDC23E) : Colors.white,
                  border: Border.all(color: const Color(0xFFFDC23E),width: 1)
              ),
              alignment: Alignment.center,
              child: Text(
                tag,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: const Color(0xFF333333),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            clickBlock: (){
              block(i);
            },)
        );

      }
    }

    return list;
  }

}
