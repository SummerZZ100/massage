

class HotKeyData {

  HotKeyData({
      this.hotKeys,});


  HotKeyData.fromJson(dynamic json) {
    hotKeys = json['hotKeys'] != null ? json['hotKeys'].cast<String>() : [];
  }

  List<String>? hotKeys;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotKeys'] = hotKeys;
    return map;
  }

}