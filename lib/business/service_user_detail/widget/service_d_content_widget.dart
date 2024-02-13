import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import 'package:massage/business/service_user_detail/widget/service_product_info_cell.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 


typedef ServiceDContentWidgetBlock = Function(Projects project);

class ServiceDContentWidget extends StatelessWidget {

  ServiceUsers serviceUser;
  ServiceDContentWidgetBlock block;
  ServiceDContentWidget({super.key,required this.serviceUser,required this.block});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 18.r,right: 18.r,top: 5.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "服务内容",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
          ListView(
            children: _projectCells(),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          )
        ],
      )
    );

  }

  _projectCells(){

    List<Widget> list = [];

    if((serviceUser.projects?.length ?? 0) > 0){
      for(int i = 0;i < serviceUser.projects!.length;i++){
        Projects project = serviceUser.projects![i];
        list.add(ServiceProductInfoCell(project: project,block: (){
           block(project);
        },));
      }
    }

    return list;

  }

}
