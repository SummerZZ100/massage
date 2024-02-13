import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/business/home/models/Projects.dart';

import '../widget/project_select_bottom.dart';
import '../widget/project_select_num_widget.dart';
import '../widget/project_select_services_widget.dart';
import '../widget/project_select_title_widget.dart';


/*
* 回调方法
* */

typedef ProjectSelectWidgetBlock = Function(int serviceItem,int num);

class ProjectSelectWidget extends StatefulWidget {

  Projects project;
  ProjectSelectWidgetBlock block;
  ProjectSelectWidget({super.key,required this.project,required this.block});

  @override
  State<ProjectSelectWidget> createState() => _ProjectSelectWidgetState();

}

class _ProjectSelectWidgetState extends State<ProjectSelectWidget> {

  int serviceItem = 0;
  int num = 1;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.r,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                ProjectSelectTitleWidget(project: widget.project,serviceItem: serviceItem,
                closeBlock: (){
                  Navigator.pop(context);
                },),
                ProjectSelectServicesWidget(
                  project: widget.project,
                  serviceItem: serviceItem,
                  block: (int item){
                    setState((){
                      serviceItem = item;
                    });
                  },
                ),
                ProjectSelectNumWidget(
                  project: widget.project,
                  number: num,
                  block: (int number){
                    setState((){
                      num = number;
                    });
                  },
                ),
              ],
            ),
          )),
          ProjectSelectBottom(
            project: widget.project,
            number: num,
            block: _sureClick,
          ),
        ],
      ),
    );
  }

  _sureClick(){
    widget.block(serviceItem,num);
    Navigator.pop(context);
  }

}


