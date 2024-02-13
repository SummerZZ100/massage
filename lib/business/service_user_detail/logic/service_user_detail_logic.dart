import 'package:get/get.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';

///  create by zhangxiaosong on 2023/9/9
///  describtion 

class ServiceUserDetailLogic extends GetxController{

  ServiceUsers serviceUser;
  final dataNotifyId = 'dataNotifyId';

  ServiceUserDetailLogic({required this.serviceUser});

  userImageUrls(){
    List<String> list = [];

    if((serviceUser.headSrc?.length ?? 0) > 0){
      list.add(serviceUser.headSrc!);
    }
    if((serviceUser.albumSrcs?.length ?? 0) > 0){
      for(int i = 0;i < serviceUser.albumSrcs!.length;i++){
        String url = serviceUser.albumSrcs![i];
        if(url.isNotEmpty && url != 'serviceUser.headSrc'){
          list.add(url);
        }
      }
    }

    return list;
  }

}