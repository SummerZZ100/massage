
class AdvertBox {

  AdvertBox({
      this.url, 
      this.width, 
      this.height,});

  AdvertBox.fromJson(dynamic json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  String? url;
  String? width;
  String? height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    return map;
  }

}