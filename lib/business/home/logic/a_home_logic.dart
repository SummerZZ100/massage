
///  create by zhangxiaosong on 2023/9/6
///  describtion

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:massage/business/home/models/location_info_model.dart';
import 'package:massage/middle/app_data_tool/app_data_tool.dart';
import 'package:massage/middle/location_data_tool.dart';
import 'package:massage/tools/util/permission_zh.dart';

import '../../../middle/network/request_interface.dart';
import '../../../tools/util/network_manager_zh.dart';
import '../models/BannerModel.dart';
import '../models/Coupon.dart';
import '../models/Main_data_response.dart';
import '../models/Projects.dart';
import '../models/ServiceUsers.dart';

class AHomeLogic extends GetxController {

  final loadingNotifyId = 'loadingNotifyId';
  final dataNotifyId = 'dataNotifyId';
  final locationNotifyId = 'locationNotifyId';

  bool netLoading = true;
  bool hasLocation = true;

  String city = '';

  List<BannerModel> banners = [];//广告栏
  List<ServiceUsers> serviceUsers = [];//所有技师列表
  List<Projects> projects = [];//所有项目列表
  List<Projects> cheapProjects = [];//特价项目列表
  List<ServiceUsers> nearbyServiceUsers = [];//附近技师列表
  List<ServiceUsers> recommendServiceUsers = [];//首页推荐技师列表
  List<Coupon> coupon =[];//优惠券列表

  AHomeLogic(){
    city = LocationDataTool.instance.city;
  }

  /*
  * 请求首页数据
  * */
  requestMainData({required bool notify, Function? success,Function? fail}){

    netLoading = true;
    if(notify){
      update([loadingNotifyId]);
    }

    RequestInterface.requestMainData().then((urlLink){
      NetworkManagerZH.instance.get(urlLink).then((value) async{

        if(value != null){

          MainDataResponse response = MainDataResponse.fromJson(value);
          await _initMyData(response);
          if(success != null){
            success();
          }

        }
        else{
          if(fail != null){
            fail();
          }
        }

        netLoading = false;
        update([loadingNotifyId,dataNotifyId]);

      });
    });


  }

  /*
  * 请求定位
  * */
  requestLocation() async {

    PermissionStatusZH permissionStatus = await PermissionZH.instance.requestLocationPermission();
    if(permissionStatus == PermissionStatusZH.granted){
      hasLocation = true;
      String url = RequestInterface.requestRegeo(log: LocationDataTool.instance.lng, lat: LocationDataTool.instance.lat);
      NetworkManagerZH.instance.get(url).then((value) async{

        if(value != null){

          LocationInfoModel response = LocationInfoModel.fromJson(value);

          if(response.regeocode?.addressComponent?.city != null){
            try{
              city = response.regeocode?.addressComponent?.city ?? "";
            }catch(e){

            }

          }
          if(city.isEmpty){
            city = response.regeocode?.addressComponent?.province ?? "";
          }
          LocationDataTool.instance.setCity(city);
          update([locationNotifyId]);

        }

      });

    }
    else{
      hasLocation = false;
    }

    update([locationNotifyId]);
  }

  changeLocationTrue(){
    hasLocation = true;
    update([locationNotifyId]);
  }


  _initMyData(MainDataResponse response) async {

    await AppDataTool.instance.initMyData(response);

    banners = AppDataTool.instance.banners;//广告栏
    projects = AppDataTool.instance.projects;//所有项目列表
    coupon = AppDataTool.instance.coupon;//优惠券列表
    cheapProjects = AppDataTool.instance.cheapProjects;//特价项目列表
    serviceUsers = AppDataTool.instance.serviceUsers;//所有技师列表
    nearbyServiceUsers = AppDataTool.instance.nearbyServiceUsers;//附近技师列表
    recommendServiceUsers = AppDataTool.instance.recommendServiceUsers;//首页推荐技师列表

  }

}
