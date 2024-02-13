import 'package:get/get.dart';

/**
 *  banner 控制器
 */

class ProjectDetailBannerLogic extends GetxController {

   final String selectedIndexStatus = 'selectedIndexStatus';

   int selectedIndex = 0;

   changeSelectedIndex(int item){
     selectedIndex = item;
     update([selectedIndexStatus]);
   }


}