import 'dart:convert';

/// uid : 1091
/// headSrc : "https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png"
/// nickname : "134****9012"
/// star : 5
/// content : "鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));
String commentsToJson(Comments data) => json.encode(data.toJson());
class Comments {
  Comments({
      num? uid, 
      String? headSrc, 
      String? nickname, 
      num? star, 
      String? content,}){
    _uid = uid;
    _headSrc = headSrc;
    _nickname = nickname;
    _star = star;
    _content = content;
}

  Comments.fromJson(dynamic json) {
    _uid = json['uid'];
    _headSrc = json['headSrc'];
    _nickname = json['nickname'];
    _star = json['star'];
    _content = json['content'];
  }
  num? _uid;
  String? _headSrc;
  String? _nickname;
  num? _star;
  String? _content;
Comments copyWith({  num? uid,
  String? headSrc,
  String? nickname,
  num? star,
  String? content,
}) => Comments(  uid: uid ?? _uid,
  headSrc: headSrc ?? _headSrc,
  nickname: nickname ?? _nickname,
  star: star ?? _star,
  content: content ?? _content,
);
  num? get uid => _uid;
  String? get headSrc => _headSrc;
  String? get nickname => _nickname;
  num? get star => _star;
  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['headSrc'] = _headSrc;
    map['nickname'] = _nickname;
    map['star'] = _star;
    map['content'] = _content;
    return map;
  }

}