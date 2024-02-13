import 'Projects.dart';
import 'Comments.dart';
import 'dart:convert';

/// id : 119
/// nickname : "杩介"
/// headSrc : "https://imgs.ituiuu.cn/cdn/uploads/disk1/u/07e1cd7dca89a1678042477183b7ac3f.jpg"
/// albumSrcs : ["https://imgs.ituiuu.cn/cdn/uploads/disk1/u/07e1cd7dca89a1678042477183b7ac3f.jpg"]
/// score : "5鏄�"
/// orderNum : 63
/// distance : 7.11
/// constellation : "閲戠墰搴�"
/// nation : "姹夋棌"
/// height : 178
/// weight : 60
/// projects : [{"id":15,"name":"姊﹀够宸撮粠SPA","services":["鑺卞紡淇濆吇","鍏ㄨ韩閲婂帇","闈欏績鑸掔紦"],"imgSrc":["https://imgs.ituiuu.cn/cdn/uploads/disk1/p/35d96b796eaf122fb3758d6b579f49b0.jpg"],"describe":"閲婃斁鍘嬪姏銆佸叏韬玈PA","oldPrice":1098,"price":598,"tags":["骞冲彴鎷呬繚 瀹樻柟璁よ瘉 鏀惰垂閫忔槑 鐖界害鍖呴€€"],"orderNum":331,"time":90,"posture":"浠板崸 淇崸","efficacyIntroduction":"SPA鍏ㄨ韩銆侀€氱瓔娲荤粶銆佷績杩涚潯鐪犮€佹秷闄ょ柌鎯箯鍔涖€佽垝缂撹В鍘�","noUsers":"楂橀緞鑰呫€佺粡鏈熴€佸鏈熴€侀璐ㄧ枏鏉俱€佷弗閲嶅績鑴忕梾楂樿鍘嬨€侀ギ閰掋€佺毊鑲ょ梾绛変汉缇ゃ€�","serviceProcess":"澶撮儴鎸夋懇-鑲╅鏀炬澗-鑵拌儗鑸掔紦-鍥涜偄鍑忓帇","suppliesProvided":"涓€娆℃€у簥鍗曘€佷竴娆℃€х煭瑁ゃ€佷竴娆℃€ф瘺宸俱€佹鐗╃簿娌�","commentTags":["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"],"comments":[{"uid":1076,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"},{"uid":1077,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈嫭鐗癸紝鏀炬澗鎰夋偊銆�"},{"uid":1078,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎸夋懇鎵嬫硶鏌斿拰锛屼护浜烘弧鎰忋€�"},{"uid":1079,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鏈嶅姟鎬佸害濂斤紝鎶€鏈竴娴併€�"},{"uid":1080,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岃韩浣撹垝閫傘€�"},{"uid":1081,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鎶€鏈竴娴侊紝鎺ㄨ崘浣撻獙銆�"},{"uid":1082,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶娓╂煍锛屼护浜洪櫠閱夈€�"},{"uid":1083,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掔紦銆�"},{"uid":1084,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢浜彈銆�"},{"uid":1085,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"},{"uid":1086,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鍔涘害閫備腑锛岃垝閫傚疁浜恒€�"},{"uid":1087,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈ù鐔燂紝鑸掔紦鐤插姵銆�"},{"uid":1088,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"涓撲笟鏈嶅姟锛屾晥鏋滄樉钁椼€�"},{"uid":1089,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇鎵嬫硶缁嗚吇锛屾斁鏉捐韩蹇冦€�"},{"uid":1090,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"鐑儏鍛ㄥ埌锛屾妧鏈笉閿欍€�"}],"positiveReviewRate":0.99,"commentNum":15},{"id":16,"name":"灏婁韩缁忕粶SPA","services":["鑺遍瑙︽劅SPA","鑸掍韩SPA","浼橀泤SPA"],"imgSrc":["https://imgs.ituiuu.cn/cdn/uploads/disk1/p/c59898f7fd461028bada187c41a1c0d9.jpg"],"describe":"缂撹В鐤插姵銆佹斁鏉捐韩浣�","oldPrice":1280,"price":698,"tags":["骞冲彴鎷呬繚 瀹樻柟璁よ瘉 鏀惰垂閫忔槑 鐖界害鍖呴€€"],"orderNum":498,"time":100,"posture":"浠板崸 淇崸","efficacyIntroduction":"SPA鍏ㄨ韩銆侀€氱瓔娲荤粶銆佹彁楂樼潯鐪犺川閲忋€佹秷闄ょ柌鎯箯鍔涖€佽垝缂撹В鍘�","noUsers":"楂橀緞鑰呫€佺粡鏈熴€佸鏈熴€侀璐ㄧ枏鏉俱€佷弗閲嶅績鑴忕梾楂樿鍘嬨€侀ギ閰掋€佺毊鑲ょ梾绛変汉缇ゃ€�","serviceProcess":"澶撮儴鎸夋懇-鑲╅鏀炬澗-鑵拌儗鑸掔紦-鍥涜偄鍑忓帇","suppliesProvided":"涓€娆℃€у簥鍗曘€佷竴娆℃€х煭瑁ゃ€佷竴娆℃€ф瘺宸俱€佹鐗╃簿娌�","commentTags":["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"],"comments":[{"uid":1091,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"},{"uid":1092,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈嫭鐗癸紝鏀炬澗鎰夋偊銆�"},{"uid":1093,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎸夋懇鎵嬫硶鏌斿拰锛屼护浜烘弧鎰忋€�"},{"uid":1094,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鏈嶅姟鎬佸害濂斤紝鎶€鏈竴娴併€�"},{"uid":1095,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"鎸夋懇鍔涘害閫傚疁锛岃韩浣撹垝閫傘€�"},{"uid":1096,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎶€鏈笓涓氾紝鏀炬澗韬績銆�"},{"uid":1097,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶鐙壒锛屾晥鏋滃ソ銆�"},{"uid":1098,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掗€傘€�"},{"uid":1099,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢鑸掓湇銆�"},{"uid":1100,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"}],"positiveReviewRate":0.98,"commentNum":10}]
/// commentTags : ["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"]
/// commentNum : 6
/// positiveReviewRate : 1
/// comments : [{"uid":1096,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎶€鏈笓涓氾紝鏀炬澗韬績銆�"},{"uid":1097,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶鐙壒锛屾晥鏋滃ソ銆�"},{"uid":1098,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掗€傘€�"},{"uid":1099,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢鑸掓湇銆�"},{"uid":1100,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"}]

ServiceUsers serviceUsersFromJson(String str) => ServiceUsers.fromJson(json.decode(str));
String serviceUsersToJson(ServiceUsers data) => json.encode(data.toJson());
class ServiceUsers {
  ServiceUsers({
      num? id, 
      String? nickname, 
      String? headSrc, 
      List<String>? albumSrcs, 
      String? score, 
      num? orderNum, 
      num? distance, 
      String? constellation, 
      String? nation, 
      num? height, 
      num? weight, 
      List<Projects>? projects, 
      List<String>? commentTags, 
      num? commentNum, 
      num? positiveReviewRate, 
      List<Comments>? comments,}){
    _id = id;
    _nickname = nickname;
    _headSrc = headSrc;
    _albumSrcs = albumSrcs;
    _score = score;
    _orderNum = orderNum;
    _distance = distance;
    _constellation = constellation;
    _nation = nation;
    _height = height;
    _weight = weight;
    _projects = projects;
    _commentTags = commentTags;
    _commentNum = commentNum;
    _positiveReviewRate = positiveReviewRate;
    _comments = comments;
}

  ServiceUsers.fromJson(dynamic json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _headSrc = json['headSrc'];
    _albumSrcs = json['albumSrcs'] != null ? json['albumSrcs'].cast<String>() : [];
    _score = json['score'];
    _orderNum = json['orderNum'];
    _distance = json['distance'];
    _constellation = json['constellation'];
    _nation = json['nation'];
    _height = json['height'];
    _weight = json['weight'];
    if (json['projects'] != null) {
      _projects = [];
      json['projects'].forEach((v) {
        _projects?.add(Projects.fromJson(v));
      });
    }
    _commentTags = json['commentTags'] != null ? json['commentTags'].cast<String>() : [];
    _commentNum = json['commentNum'];
    _positiveReviewRate = json['positiveReviewRate'];
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comments.fromJson(v));
      });
    }
  }
  num? _id;
  String? _nickname;
  String? _headSrc;
  List<String>? _albumSrcs;
  String? _score;
  num? _orderNum;
  num? _distance;
  String? _constellation;
  String? _nation;
  num? _height;
  num? _weight;
  List<Projects>? _projects;
  List<String>? _commentTags;
  num? _commentNum;
  num? _positiveReviewRate;
  List<Comments>? _comments;
ServiceUsers copyWith({  num? id,
  String? nickname,
  String? headSrc,
  List<String>? albumSrcs,
  String? score,
  num? orderNum,
  num? distance,
  String? constellation,
  String? nation,
  num? height,
  num? weight,
  List<Projects>? projects,
  List<String>? commentTags,
  num? commentNum,
  num? positiveReviewRate,
  List<Comments>? comments,
}) => ServiceUsers(  id: id ?? _id,
  nickname: nickname ?? _nickname,
  headSrc: headSrc ?? _headSrc,
  albumSrcs: albumSrcs ?? _albumSrcs,
  score: score ?? _score,
  orderNum: orderNum ?? _orderNum,
  distance: distance ?? _distance,
  constellation: constellation ?? _constellation,
  nation: nation ?? _nation,
  height: height ?? _height,
  weight: weight ?? _weight,
  projects: projects ?? _projects,
  commentTags: commentTags ?? _commentTags,
  commentNum: commentNum ?? _commentNum,
  positiveReviewRate: positiveReviewRate ?? _positiveReviewRate,
  comments: comments ?? _comments,
);
  num? get id => _id;
  String? get nickname => _nickname;
  String? get headSrc => _headSrc;
  List<String>? get albumSrcs => _albumSrcs;
  String? get score => _score;
  num? get orderNum => _orderNum;
  num? get distance => _distance;
  String? get constellation => _constellation;
  String? get nation => _nation;
  num? get height => _height;
  num? get weight => _weight;
  List<Projects>? get projects => _projects;
  List<String>? get commentTags => _commentTags;
  num? get commentNum => _commentNum;
  num? get positiveReviewRate => _positiveReviewRate;
  List<Comments>? get comments => _comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nickname'] = _nickname;
    map['headSrc'] = _headSrc;
    map['albumSrcs'] = _albumSrcs;
    map['score'] = _score;
    map['orderNum'] = _orderNum;
    map['distance'] = _distance;
    map['constellation'] = _constellation;
    map['nation'] = _nation;
    map['height'] = _height;
    map['weight'] = _weight;
    if (_projects != null) {
      map['projects'] = _projects?.map((v) => v.toJson()).toList();
    }
    map['commentTags'] = _commentTags;
    map['commentNum'] = _commentNum;
    map['positiveReviewRate'] = _positiveReviewRate;
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}