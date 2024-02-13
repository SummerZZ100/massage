
class WaiterCare {
  WaiterCare({
      this.careList,});

  WaiterCare.fromJson(dynamic json) {
    careList = json['careList'] != null ? json['careList'].cast<num>() : [];
  }
  List<num>? careList;

WaiterCare copyWith({  List<num>? careList,
}) => WaiterCare(  careList: careList ?? this.careList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['careList'] = careList;
    return map;
  }

}