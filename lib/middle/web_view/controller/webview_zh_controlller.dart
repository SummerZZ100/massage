import 'package:get/get.dart';

/**
 *  create by zhangxiaosong on 2022/3/7
 *  webView 数据提供者
 */

class WebViewZHController extends GetxController {

  int? progress;//加载进度
  bool isLoading = true;//是否进行网络加载中
  bool canBack = true;//是否可返回

  final String navStatus = 'navStatus';//导航栏状态刷新
  final String loadingStatus = 'loadingStatus';//网络加载框 状态刷新

  /*
  * 修改进度条
  * */
  changeProgress(int progress){
    this.progress = progress;
    update([navStatus]);
  }

  /*
  * 修改导航栏状态
  * */
  updateNav(){
    update([navStatus]);
  }

  /*
  * 改变网络加载状态
  * */
  changeLoadingStatus(bool isL){
    isLoading = isL;
    update([loadingStatus]);
  }

  changeBackStatus(bool value){
    canBack = value;
    update([navStatus]);
  }



}
