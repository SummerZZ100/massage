import 'Comments.dart';
import 'dart:convert';

/// id : 16
/// name : "灏婁韩缁忕粶SPA"
/// services : ["鑺遍瑙︽劅SPA","鑸掍韩SPA","浼橀泤SPA"]
/// imgSrc : ["https://imgs.ituiuu.cn/cdn/uploads/disk1/p/c59898f7fd461028bada187c41a1c0d9.jpg"]
/// describe : "缂撹В鐤插姵銆佹斁鏉捐韩浣�"
/// oldPrice : 1280
/// price : 698
/// tags : ["骞冲彴鎷呬繚 瀹樻柟璁よ瘉 鏀惰垂閫忔槑 鐖界害鍖呴€€"]
/// orderNum : 498
/// time : 100
/// posture : "浠板崸 淇崸"
/// efficacyIntroduction : "SPA鍏ㄨ韩銆侀€氱瓔娲荤粶銆佹彁楂樼潯鐪犺川閲忋€佹秷闄ょ柌鎯箯鍔涖€佽垝缂撹В鍘�"
/// noUsers : "楂橀緞鑰呫€佺粡鏈熴€佸鏈熴€侀璐ㄧ枏鏉俱€佷弗閲嶅績鑴忕梾楂樿鍘嬨€侀ギ閰掋€佺毊鑲ょ梾绛変汉缇ゃ€�"
/// serviceProcess : "澶撮儴鎸夋懇-鑲╅鏀炬澗-鑵拌儗鑸掔紦-鍥涜偄鍑忓帇"
/// suppliesProvided : "涓€娆℃€у簥鍗曘€佷竴娆℃€х煭瑁ゃ€佷竴娆℃€ф瘺宸俱€佹鐗╃簿娌�"
/// commentTags : ["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"]
/// comments : [{"uid":1091,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"},{"uid":1092,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈嫭鐗癸紝鏀炬澗鎰夋偊銆�"},{"uid":1093,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎸夋懇鎵嬫硶鏌斿拰锛屼护浜烘弧鎰忋€�"},{"uid":1094,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鏈嶅姟鎬佸害濂斤紝鎶€鏈竴娴併€�"},{"uid":1095,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"鎸夋懇鍔涘害閫傚疁锛岃韩浣撹垝閫傘€�"},{"uid":1096,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎶€鏈笓涓氾紝鏀炬澗韬績銆�"},{"uid":1097,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶鐙壒锛屾晥鏋滃ソ銆�"},{"uid":1098,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掗€傘€�"},{"uid":1099,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢鑸掓湇銆�"},{"uid":1100,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"}]
/// positiveReviewRate : 0.98
/// commentNum : 10

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));
String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  Projects({
      num? id, 
      String? name, 
      List<String>? services, 
      List<String>? imgSrc, 
      String? describe, 
      num? oldPrice, 
      num? price, 
      List<String>? tags, 
      num? orderNum, 
      num? time, 
      String? posture, 
      String? efficacyIntroduction, 
      String? noUsers, 
      String? serviceProcess, 
      String? suppliesProvided, 
      List<String>? commentTags, 
      List<Comments>? comments, 
      num? positiveReviewRate, 
      num? commentNum,}){

    _id = id;
    _name = name;
    _services = services;
    _imgSrc = imgSrc;
    _describe = describe;
    _oldPrice = oldPrice;
    _price = price;
    _tags = tags;
    _orderNum = orderNum;
    _time = time;
    _posture = posture;
    _efficacyIntroduction = efficacyIntroduction;
    _noUsers = noUsers;
    _serviceProcess = serviceProcess;
    _suppliesProvided = suppliesProvided;
    _commentTags = commentTags;
    _comments = comments;
    _positiveReviewRate = positiveReviewRate;
    _commentNum = commentNum;
}

  Projects.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _services = json['services'] != null ? json['services'].cast<String>() : [];
    _imgSrc = json['imgSrc'] != null ? json['imgSrc'].cast<String>() : [];
    _describe = json['describe'];
    _oldPrice = json['oldPrice'];
    _price = json['price'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _orderNum = json['orderNum'];
    _time = json['time'];
    _posture = json['posture'];
    _efficacyIntroduction = json['efficacyIntroduction'];
    _noUsers = json['noUsers'];
    _serviceProcess = json['serviceProcess'];
    _suppliesProvided = json['suppliesProvided'];
    _commentTags = json['commentTags'] != null ? json['commentTags'].cast<String>() : [];
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comments.fromJson(v));
      });
    }
    _positiveReviewRate = json['positiveReviewRate'];
    _commentNum = json['commentNum'];
  }
  num? _id;
  String? _name;
  List<String>? _services;
  List<String>? _imgSrc;
  String? _describe;
  num? _oldPrice;
  num? _price;
  List<String>? _tags;
  num? _orderNum;
  num? _time;
  String? _posture;
  String? _efficacyIntroduction;
  String? _noUsers;
  String? _serviceProcess;
  String? _suppliesProvided;
  List<String>? _commentTags;
  List<Comments>? _comments;
  num? _positiveReviewRate;
  num? _commentNum;

Projects copyWith({  num? id,
  String? name,
  List<String>? services,
  List<String>? imgSrc,
  String? describe,
  num? oldPrice,
  num? price,
  List<String>? tags,
  num? orderNum,
  num? time,
  String? posture,
  String? efficacyIntroduction,
  String? noUsers,
  String? serviceProcess,
  String? suppliesProvided,
  List<String>? commentTags,
  List<Comments>? comments,
  num? positiveReviewRate,
  num? commentNum,
}) => Projects(  id: id ?? _id,
  name: name ?? _name,
  services: services ?? _services,
  imgSrc: imgSrc ?? _imgSrc,
  describe: describe ?? _describe,
  oldPrice: oldPrice ?? _oldPrice,
  price: price ?? _price,
  tags: tags ?? _tags,
  orderNum: orderNum ?? _orderNum,
  time: time ?? _time,
  posture: posture ?? _posture,
  efficacyIntroduction: efficacyIntroduction ?? _efficacyIntroduction,
  noUsers: noUsers ?? _noUsers,
  serviceProcess: serviceProcess ?? _serviceProcess,
  suppliesProvided: suppliesProvided ?? _suppliesProvided,
  commentTags: commentTags ?? _commentTags,
  comments: comments ?? _comments,
  positiveReviewRate: positiveReviewRate ?? _positiveReviewRate,
  commentNum: commentNum ?? _commentNum,
);
  num? get id => _id;
  String? get name => _name;
  List<String>? get services => _services;
  List<String>? get imgSrc => _imgSrc;
  String? get describe => _describe;
  num? get oldPrice => _oldPrice;
  num? get price => _price;
  List<String>? get tags => _tags;
  num? get orderNum => _orderNum;
  num? get time => _time;
  String? get posture => _posture;
  String? get efficacyIntroduction => _efficacyIntroduction;
  String? get noUsers => _noUsers;
  String? get serviceProcess => _serviceProcess;
  String? get suppliesProvided => _suppliesProvided;
  List<String>? get commentTags => _commentTags;
  List<Comments>? get comments => _comments;
  num? get positiveReviewRate => _positiveReviewRate;
  num? get commentNum => _commentNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['services'] = _services;
    map['imgSrc'] = _imgSrc;
    map['describe'] = _describe;
    map['oldPrice'] = _oldPrice;
    map['price'] = _price;
    map['tags'] = _tags;
    map['orderNum'] = _orderNum;
    map['time'] = _time;
    map['posture'] = _posture;
    map['efficacyIntroduction'] = _efficacyIntroduction;
    map['noUsers'] = _noUsers;
    map['serviceProcess'] = _serviceProcess;
    map['suppliesProvided'] = _suppliesProvided;
    map['commentTags'] = _commentTags;
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    map['positiveReviewRate'] = _positiveReviewRate;
    map['commentNum'] = _commentNum;
    return map;
  }

}