
class ContactAddressModel {

  ContactAddressModel({
      this.contactName, 
      this.contactPhone, 
      this.city, 
      this.addressDetail, 
      this.isDefault,
      this.type,
      this.sex,
      this.cId,
  });

  ContactAddressModel.fromJson(dynamic json) {
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    city = json['city'];
    addressDetail = json['addressDetail'];
    isDefault = json['isDefault'];
    type = json['type'];
    sex = json['sex'];
    cId = json['cId'];
  }
  num? cId;
  String? contactName;
  String? contactPhone;
  String? city;
  String? addressDetail;
  bool? isDefault;
  int? type;//1 家  2:公司
  String? sex;// 先生  女士

ContactAddressModel copyWith({  String? contactName,
  String? contactPhone,
  String? city,
  String? addressDetail,
  bool? isDefault,
  int? type,
  String? sex,
  num? cId,
}) => ContactAddressModel(contactName: contactName ?? this.contactName,
  contactPhone: contactPhone ?? this.contactPhone,
  city: city ?? this.city,
  addressDetail: addressDetail ?? this.addressDetail,
  isDefault: isDefault ?? this.isDefault,
  type: type ?? this.type,
  sex: sex ?? this.sex,
  cId: cId ?? this.cId
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactName'] = contactName;
    map['contactPhone'] = contactPhone;
    map['city'] = city;
    map['addressDetail'] = addressDetail;
    map['isDefault'] = isDefault;
    map['type'] = type;
    map['sex'] = sex;
    map['cId'] = cId;
    return map;
  }

}