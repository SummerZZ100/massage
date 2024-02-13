
import 'Contact_address_model.dart';

class ContactAddressList {

  ContactAddressList({
      this.addressList,});

  ContactAddressList.fromJson(dynamic json) {
    if (json['addressList'] != null) {
      addressList = [];
      json['addressList'].forEach((v) {
        addressList?.add(ContactAddressModel.fromJson(v));
      });
    }
  }

  List<ContactAddressModel>? addressList;

ContactAddressList copyWith({  List<ContactAddressModel>? addressList,
}) => ContactAddressList(  addressList: addressList ?? this.addressList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressList != null) {
      map['addressList'] = addressList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}