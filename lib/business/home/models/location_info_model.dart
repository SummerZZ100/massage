
class LocationInfoModel {

  LocationInfoModel({
      this.status, 
      this.regeocode,});

  LocationInfoModel.fromJson(dynamic json) {
    status = json['status'];
    regeocode = json['regeocode'] != null ? Regeocode.fromJson(json['regeocode']) : null;
  }

  String? status;
  Regeocode? regeocode;

LocationInfoModel copyWith({  String? status,
  Regeocode? regeocode,
}) => LocationInfoModel(  status: status ?? this.status,
  regeocode: regeocode ?? this.regeocode,
);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (regeocode != null) {
      map['regeocode'] = regeocode?.toJson();
    }
    return map;
  }

}

class Regeocode {
  Regeocode({
      this.addressComponent, 
      this.formattedAddress,});

  Regeocode.fromJson(dynamic json) {
    addressComponent = json['addressComponent'] != null ? AddressComponent.fromJson(json['addressComponent']) : null;
    formattedAddress = json['formatted_address'];
  }
  AddressComponent? addressComponent;
  String? formattedAddress;
Regeocode copyWith({  AddressComponent? addressComponent,
  String? formattedAddress,
}) => Regeocode(  addressComponent: addressComponent ?? this.addressComponent,
  formattedAddress: formattedAddress ?? this.formattedAddress,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressComponent != null) {
      map['addressComponent'] = addressComponent?.toJson();
    }
    map['formatted_address'] = formattedAddress;
    return map;
  }

}

class AddressComponent {
  AddressComponent({
      this.city, 
      this.province, 
      this.adcode, 
      this.district, 
      this.towncode, 
      this.country, 
      this.township, 
      this.citycode,});

  AddressComponent.fromJson(dynamic json) {
    city = json['city'];
    province = json['province'];
    adcode = json['adcode'];
    district = json['district'];
    towncode = json['towncode'];
    country = json['country'];
    township = json['township'];
    citycode = json['citycode'];
  }
  dynamic city;
  String? province;
  String? adcode;
  String? district;
  String? towncode;
  String? country;
  String? township;
  String? citycode;
AddressComponent copyWith({  dynamic city,
  String? province,
  String? adcode,
  String? district,
  String? towncode,
  String? country,
  String? township,
  String? citycode,
}) => AddressComponent(  city: city ?? this.city,
  province: province ?? this.province,
  adcode: adcode ?? this.adcode,
  district: district ?? this.district,
  towncode: towncode ?? this.towncode,
  country: country ?? this.country,
  township: township ?? this.township,
  citycode: citycode ?? this.citycode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['province'] = province;
    map['adcode'] = adcode;
    map['district'] = district;
    map['towncode'] = towncode;
    map['country'] = country;
    map['township'] = township;
    map['citycode'] = citycode;
    return map;
  }

}