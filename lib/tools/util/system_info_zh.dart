/**
 *  describtion  手机系统信息获取
 */

import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';


///平台
enum PlatformType {
  iOS,
  android,
}

/*
* 获取系统信息
* */
class SystemInfoZH {


  ///平台涞源
  static PlatformType osPlatform() {
    PlatformType type = PlatformType.iOS;

    if(Platform.isIOS){
      type = PlatformType.iOS;
    }
    else if(Platform.isAndroid){
      type = PlatformType.android;
    }
    return type;
  }


  ///设备信息
  static Future<String> deviceModel() async {
    String device = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      IosDeviceInfo iosDev = await deviceInfo.iosInfo;
      device = iosDev.model;
    }
    else if(Platform.isAndroid){
      AndroidDeviceInfo androidDev = await deviceInfo.androidInfo;
      device = androidDev.device;
    }
    return device;
  }

  ///设备idfa
  static Future<String> idfa() async {
    String imeiStr = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      IosDeviceInfo iosDev = await deviceInfo.iosInfo;
      imeiStr = iosDev.identifierForVendor;
    }
    else if(Platform.isAndroid){
      AndroidDeviceInfo androidDev = await deviceInfo.androidInfo;
      imeiStr = androidDev.androidId;
    }
    return imeiStr;
  }


  ///设备imei
  static Future<String> hardIMEI() async {
    String imeiStr = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      IosDeviceInfo iosDev = await deviceInfo.iosInfo;
      imeiStr = iosDev.identifierForVendor;
    }
    else if(Platform.isAndroid){
      AndroidDeviceInfo androidDev = await deviceInfo.androidInfo;
      imeiStr = androidDev.androidId;
    }
    return imeiStr;
  }

  ///获取app版本号
  static Future<String> packageVersion() async{
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  /*
  * 获取app构建版本
  * */
  static Future<String> packageBuildNumber() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.buildNumber;
  }



}


