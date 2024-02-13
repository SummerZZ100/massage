
import 'package:get/get.dart';

import '../../home/models/Projects.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class SpecialProjectsLogic extends GetxController {

  List<Projects> cheapProjects = [];//特价项目列表
  final dataNotifyId = 'dataNotifyId';

  SpecialProjectsLogic({required this.cheapProjects});

}