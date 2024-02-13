
class CouponIdList {
  CouponIdList({
      this.couponIds,});

  CouponIdList.fromJson(dynamic json) {
    couponIds = json['couponIds'] != null ? json['couponIds'].cast<num>() : [];
  }
  List<num>? couponIds;

CouponIdList copyWith({  List<num>? couponIds,
}) => CouponIdList(  couponIds: couponIds ?? this.couponIds,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['couponIds'] = couponIds;
    return map;
  }

}