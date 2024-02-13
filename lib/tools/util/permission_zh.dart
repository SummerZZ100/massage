/**
 *  本地权限获取
 */


import 'package:permission_handler/permission_handler.dart';

enum PermissionStatusZH {
  /// 拒绝
  denied,
  /// 同意
  granted,
  /// 已经拒绝
  permanentlyDenied,
}

class PermissionZH {

  //工厂模式
  static final PermissionZH _instance = PermissionZH();
  static PermissionZH get instance => _instance;

  /*
  * 请求定位权限,并返回是否已经获取该权限
  * onlyOne : 只申请一次
  * */
  Future<PermissionStatusZH> requestLocationPermission() async {

    //获取当前的权限
    PermissionStatus status = await Permission.location.status;

    print("status === $status");
    if (status == PermissionStatus.granted) {
      //已经授权
      return PermissionStatusZH.granted;
    } else if(status == PermissionStatus.denied){
      PermissionStatus s = await Permission.location.request();
      if (s == PermissionStatus.granted) {
        return PermissionStatusZH.granted;
      } else {
        return PermissionStatusZH.denied;
      }
    }
    return PermissionStatusZH.denied;

  }

  /*
  *
  * 请求访问相册权限
  * */
  Future<PermissionStatusZH> requestPhotosPermission() async {

    //获取当前的权限
    PermissionStatus status = await Permission.photos.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return PermissionStatusZH.granted;
    }
    else{
      PermissionStatus permissions = await Permission.photos.request();
      if (permissions.isGranted) {
        return PermissionStatusZH.granted;
      } else {
        return PermissionStatusZH.denied;
      }
    }

  }

  /*
  * 请求摄像头
  * */
  Future<PermissionStatusZH> requestCameraPermission() async {

    //获取当前的权限
    PermissionStatus status = await Permission.camera.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return PermissionStatusZH.granted;
    }
    else{
      PermissionStatus permissions = await Permission.camera.request();
      if (permissions.isGranted) {
        return PermissionStatusZH.granted;
      } else {
        return PermissionStatusZH.denied;
      }
    }

  }


}
