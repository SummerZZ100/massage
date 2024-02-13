import 'dart:convert';

/// id : 3
/// imgSrc : "https://imgs.ituiuu.cn/cdn/uploads/disk1/b/12df53fea8b3adfa6c2ec456dd22e204.png"
/// linkUrl : ""

BannerModel bannerFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerToJson(BannerModel data) => json.encode(data.toJson());
class BannerModel {
  BannerModel({
      num? id, 
      String? imgSrc, 
      String? linkUrl,}){
    _id = id;
    _imgSrc = imgSrc;
    _linkUrl = linkUrl;
}

  BannerModel.fromJson(dynamic json) {
    _id = json['id'];
    _imgSrc = json['imgSrc'];
    _linkUrl = json['linkUrl'];
  }
  num? _id;
  String? _imgSrc;
  String? _linkUrl;
  BannerModel copyWith({  num? id,
  String? imgSrc,
  String? linkUrl,
}) => BannerModel(  id: id ?? _id,
  imgSrc: imgSrc ?? _imgSrc,
  linkUrl: linkUrl ?? _linkUrl,
);
  num? get id => _id;
  String? get imgSrc => _imgSrc;
  String? get linkUrl => _linkUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['imgSrc'] = _imgSrc;
    map['linkUrl'] = _linkUrl;
    return map;
  }

}