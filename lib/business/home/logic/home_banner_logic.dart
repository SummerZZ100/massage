import 'package:get/get.dart';

/**
 *  首页banner 控制器
 */

class HomeBannerLogic extends GetxController {

   final String selectedIndexStatus = 'selectedIndexStatus';

   int selectedIndex = 0;

   changeSelectedIndex(int item){

     selectedIndex = item;
     update([selectedIndexStatus]);

   }


}