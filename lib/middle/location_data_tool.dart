import 'package:location/location.dart';

import 'network/request_interface.dart';

///  定位数据


class LocationDataTool {

  static final LocationDataTool _instance = LocationDataTool();
  static LocationDataTool get instance => _instance;

  String lng = '0.0';
  String lat = '0.0';
  String city = '';
  Location location = Location();

  setLocationData({String? longitude,String? latitude})
  {
    print("lo==  $longitude $latitude");
    lng = longitude ?? '0.0';
    lat = latitude ?? '0.0';
    RequestInterface.baseParams();
  }

  setCity(String cityName){
    city = cityName;
  }

  requestMyLocation() async {

    await location.changeSettings(accuracy: LocationAccuracy.balanced);
    LocationData currentLocation = await location.getLocation();
    setLocationData(longitude: '${currentLocation.longitude ?? 0.0}',latitude: '${currentLocation.latitude ?? 0.0}');

  }

}
