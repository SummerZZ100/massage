class InteractiveUsers {
  InteractiveUsers({
      this.key,
      this.cares, 
      this.blacks,});

  InteractiveUsers.fromJson(dynamic json) {
    key = json['key'];
    cares = json['cares'] != null ? json['cares'].cast<num>() : [];
    blacks = json['blacks'] != null ? json['blacks'].cast<num>() : [];
  }
  String? key;
  List<num>? cares;
  List<num>? blacks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['cares'] = cares;
    map['blacks'] = blacks;
    return map;
  }

}