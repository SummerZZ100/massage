import 'BannerModel.dart';
import 'ServiceUsers.dart';
import 'Projects.dart';
import 'Coupon.dart';
import 'dart:convert';

/// banners : [{"id":3,"imgSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/b/12df53fea8b3adfa6c2ec456dd22e204.png","linkUrl":""}]
/// service_users : {"id":119,"nickname":"杩介","headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/u/07e1cd7dca89a1678042477183b7ac3f.jpg","albumSrcs":["https://imgs.ituiuu.cn/cdn/uploads/disk1/u/07e1cd7dca89a1678042477183b7ac3f.jpg"],"score":"5鏄�","orderNum":63,"distance":7.11,"constellation":"閲戠墰搴�","nation":"姹夋棌","height":178,"weight":60,"projects":[{"id":15,"name":"姊﹀够宸撮粠SPA","services":["鑺卞紡淇濆吇","鍏ㄨ韩閲婂帇","闈欏績鑸掔紦"],"imgSrc":["https://imgs.ituiuu.cn/cdn/uploads/disk1/p/35d96b796eaf122fb3758d6b579f49b0.jpg"],"describe":"閲婃斁鍘嬪姏銆佸叏韬玈PA","oldPrice":1098,"price":598,"tags":["骞冲彴鎷呬繚 瀹樻柟璁よ瘉 鏀惰垂閫忔槑 鐖界害鍖呴€€"],"orderNum":331,"time":90,"posture":"浠板崸 淇崸","efficacyIntroduction":"SPA鍏ㄨ韩銆侀€氱瓔娲荤粶銆佷績杩涚潯鐪犮€佹秷闄ょ柌鎯箯鍔涖€佽垝缂撹В鍘�","noUsers":"楂橀緞鑰呫€佺粡鏈熴€佸鏈熴€侀璐ㄧ枏鏉俱€佷弗閲嶅績鑴忕梾楂樿鍘嬨€侀ギ閰掋€佺毊鑲ょ梾绛変汉缇ゃ€�","serviceProcess":"澶撮儴鎸夋懇-鑲╅鏀炬澗-鑵拌儗鑸掔紦-鍥涜偄鍑忓帇","suppliesProvided":"涓€娆℃€у簥鍗曘€佷竴娆℃€х煭瑁ゃ€佷竴娆℃€ф瘺宸俱€佹鐗╃簿娌�","commentTags":["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"],"comments":[{"uid":1076,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"},{"uid":1077,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈嫭鐗癸紝鏀炬澗鎰夋偊銆�"},{"uid":1078,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎸夋懇鎵嬫硶鏌斿拰锛屼护浜烘弧鎰忋€�"},{"uid":1079,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鏈嶅姟鎬佸害濂斤紝鎶€鏈竴娴併€�"},{"uid":1080,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岃韩浣撹垝閫傘€�"},{"uid":1081,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鎶€鏈竴娴侊紝鎺ㄨ崘浣撻獙銆�"},{"uid":1082,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶娓╂煍锛屼护浜洪櫠閱夈€�"},{"uid":1083,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掔紦銆�"},{"uid":1084,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢浜彈銆�"},{"uid":1085,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"},{"uid":1086,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鍔涘害閫備腑锛岃垝閫傚疁浜恒€�"},{"uid":1087,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈ù鐔燂紝鑸掔紦鐤插姵銆�"},{"uid":1088,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"涓撲笟鏈嶅姟锛屾晥鏋滄樉钁椼€�"},{"uid":1089,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇鎵嬫硶缁嗚吇锛屾斁鏉捐韩蹇冦€�"},{"uid":1090,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"鐑儏鍛ㄥ埌锛屾妧鏈笉閿欍€�"}],"positiveReviewRate":0.99,"commentNum":15},{"id":16,"name":"灏婁韩缁忕粶SPA","services":["鑺遍瑙︽劅SPA","鑸掍韩SPA","浼橀泤SPA"],"imgSrc":["https://imgs.ituiuu.cn/cdn/uploads/disk1/p/c59898f7fd461028bada187c41a1c0d9.jpg"],"describe":"缂撹В鐤插姵銆佹斁鏉捐韩浣�","oldPrice":1280,"price":698,"tags":["骞冲彴鎷呬繚 瀹樻柟璁よ瘉 鏀惰垂閫忔槑 鐖界害鍖呴€€"],"orderNum":498,"time":100,"posture":"浠板崸 淇崸","efficacyIntroduction":"SPA鍏ㄨ韩銆侀€氱瓔娲荤粶銆佹彁楂樼潯鐪犺川閲忋€佹秷闄ょ柌鎯箯鍔涖€佽垝缂撹В鍘�","noUsers":"楂橀緞鑰呫€佺粡鏈熴€佸鏈熴€侀璐ㄧ枏鏉俱€佷弗閲嶅績鑴忕梾楂樿鍘嬨€侀ギ閰掋€佺毊鑲ょ梾绛変汉缇ゃ€�","serviceProcess":"澶撮儴鎸夋懇-鑲╅鏀炬澗-鑵拌儗鑸掔紦-鍥涜偄鍑忓帇","suppliesProvided":"涓€娆℃€у簥鍗曘€佷竴娆℃€х煭瑁ゃ€佷竴娆℃€ф瘺宸俱€佹鐗╃簿娌�","commentTags":["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"],"comments":[{"uid":1091,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"},{"uid":1092,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈嫭鐗癸紝鏀炬澗鎰夋偊銆�"},{"uid":1093,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎸夋懇鎵嬫硶鏌斿拰锛屼护浜烘弧鎰忋€�"},{"uid":1094,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鏈嶅姟鎬佸害濂斤紝鎶€鏈竴娴併€�"},{"uid":1095,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"鎸夋懇鍔涘害閫傚疁锛岃韩浣撹垝閫傘€�"},{"uid":1096,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎶€鏈笓涓氾紝鏀炬澗韬績銆�"},{"uid":1097,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶鐙壒锛屾晥鏋滃ソ銆�"},{"uid":1098,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掗€傘€�"},{"uid":1099,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢鑸掓湇銆�"},{"uid":1100,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"}],"positiveReviewRate":0.98,"commentNum":10}],"commentTags":["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"],"commentNum":6,"positiveReviewRate":1,"comments":[{"uid":1096,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎶€鏈笓涓氾紝鏀炬澗韬績銆�"},{"uid":1097,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶鐙壒锛屾晥鏋滃ソ銆�"},{"uid":1098,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掗€傘€�"},{"uid":1099,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢鑸掓湇銆�"},{"uid":1100,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"}]}
/// projects : {"id":16,"name":"灏婁韩缁忕粶SPA","services":["鑺遍瑙︽劅SPA","鑸掍韩SPA","浼橀泤SPA"],"imgSrc":["https://imgs.ituiuu.cn/cdn/uploads/disk1/p/c59898f7fd461028bada187c41a1c0d9.jpg"],"describe":"缂撹В鐤插姵銆佹斁鏉捐韩浣�","oldPrice":1280,"price":698,"tags":["骞冲彴鎷呬繚 瀹樻柟璁よ瘉 鏀惰垂閫忔槑 鐖界害鍖呴€€"],"orderNum":498,"time":100,"posture":"浠板崸 淇崸","efficacyIntroduction":"SPA鍏ㄨ韩銆侀€氱瓔娲荤粶銆佹彁楂樼潯鐪犺川閲忋€佹秷闄ょ柌鎯箯鍔涖€佽垝缂撹В鍘�","noUsers":"楂橀緞鑰呫€佺粡鏈熴€佸鏈熴€侀璐ㄧ枏鏉俱€佷弗閲嶅績鑴忕梾楂樿鍘嬨€侀ギ閰掋€佺毊鑲ょ梾绛変汉缇ゃ€�","serviceProcess":"澶撮儴鎸夋懇-鑲╅鏀炬澗-鑵拌儗鑸掔紦-鍥涜偄鍑忓帇","suppliesProvided":"涓€娆℃€у簥鍗曘€佷竴娆℃€х煭瑁ゃ€佷竴娆℃€ф瘺宸俱€佹鐗╃簿娌�","commentTags":["鎬т环姣旈珮","鎵嬫硶涓撲笟","绌翠綅鍑�","鎺屾彙鍔涘害"],"comments":[{"uid":1091,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎸夋懇鑸掗€傦紝韬綋鏀炬澗銆�"},{"uid":1092,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎶€鏈嫭鐗癸紝鏀炬澗鎰夋偊銆�"},{"uid":1093,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎸夋懇鎵嬫硶鏌斿拰锛屼护浜烘弧鎰忋€�"},{"uid":1094,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鏈嶅姟鎬佸害濂斤紝鎶€鏈竴娴併€�"},{"uid":1095,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"鎸夋懇鍔涘害閫傚疁锛岃韩浣撹垝閫傘€�"},{"uid":1096,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"134****9012","star":5,"content":"鎶€鏈笓涓氾紝鏀炬澗韬績銆�"},{"uid":1097,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"136****3456","star":5,"content":"鎸夋懇鎵嬫硶鐙壒锛屾晥鏋滃ソ銆�"},{"uid":1098,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"138****7890","star":5,"content":"鎶€鏈簿婀涳紝韬綋鑸掗€傘€�"},{"uid":1099,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"137****1234","star":5,"content":"鎸夋懇浠や汉鏀炬澗锛屽緢鑸掓湇銆�"},{"uid":1100,"headSrc":"https://imgs.ituiuu.cn/cdn/uploads/disk1/c/488cb6ac4c66151001e40e61d227bf00.png","nickname":"135****5678","star":5,"content":"涓撲笟鎸夋懇锛岀枏閫氱粡缁溿€�"}],"positiveReviewRate":0.98,"commentNum":10}
/// cheap_projects : [10,11,12,13,14,15,16]
/// nearby_service_users : [111,118,105,101,107,115,103,109,113,116]
/// recommend_service_users : [111,118,100,110,104]
/// coupon : [{"type":"骞冲彴鍒�","id":8991,"title":"骞冲彴閫氱敤浼樻儬鍒�","desc":"璁㈠崟婊�100鍙娇鐢�","note":"骞冲彴閫氱敤","money":10},{"type":"骞冲彴鍒�","id":8892,"title":"骞冲彴閫氱敤浼樻儬鍒�","desc":"璁㈠崟婊�200鍙娇鐢�","note":"骞冲彴閫氱敤","money":20},{"type":"骞冲彴鍒�","id":8793,"title":"骞冲彴閫氱敤浼樻儬鍒�","desc":"璁㈠崟婊�300鍙娇鐢�","note":"骞冲彴閫氱敤","money":30},{"type":"骞冲彴鍒�","id":8694,"title":"骞冲彴閫氱敤浼樻儬鍒�","desc":"璁㈠崟婊�400鍙娇鐢�","note":"骞冲彴閫氱敤","money":40},{"type":"骞冲彴鍒�","id":8595,"title":"骞冲彴閫氱敤浼樻儬鍒�","desc":"璁㈠崟婊�500鍙娇鐢�","note":"骞冲彴閫氱敤","money":50},{"type":"骞冲彴鍒�","id":8496,"title":"骞冲彴閫氱敤浼樻儬鍒�","desc":"璁㈠崟婊�600鍙娇鐢�","note":"骞冲彴閫氱敤","money":60},{"type":"搴楅摵鍒�","id":8397,"title":"婊″噺浼樻儬鍒�","desc":"璁㈠崟婊�100鍙娇鐢�","note":"骞冲彴閫氱敤","money":10},{"type":"搴楅摵鍒�","id":8298,"title":"婊″噺浼樻儬鍒�","desc":"璁㈠崟婊�200鍙娇鐢�","note":"骞冲彴閫氱敤","money":20},{"type":"搴楅摵鍒�","id":8199,"title":"婊″噺浼樻儬鍒�","desc":"璁㈠崟婊�300鍙娇鐢�","note":"骞冲彴閫氱敤","money":30},{"type":"搴楅摵鍒�","id":8100,"title":"鏂板鎴锋弧鍑忎紭鎯犲埜","desc":"璁㈠崟婊�100鍙娇鐢�","note":"骞冲彴閫氱敤","money":10},{"type":"搴楅摵鍒�","id":8001,"title":"鏂板鎴锋弧鍑忎紭鎯犲埜","desc":"璁㈠崟婊�200鍙娇鐢�","note":"骞冲彴閫氱敤","money":20},{"type":"搴楅摵鍒�","id":7902,"title":"鏂板鎴锋弧鍑忎紭鎯犲埜","desc":"璁㈠崟婊�300鍙娇鐢�","note":"骞冲彴閫氱敤","money":30}]

MainDataResponse mainDataResponseFromJson(String str) => MainDataResponse.fromJson(json.decode(str));

String mainDataResponseToJson(MainDataResponse data) => json.encode(data.toJson());

class MainDataResponse {
  MainDataResponse({
      List<BannerModel>? banners,
      List<ServiceUsers>? serviceUsers,
      List<Projects>? projects,
      List<num>? cheapProjects, 
      List<num>? nearbyServiceUsers, 
      List<num>? recommendServiceUsers, 
      List<Coupon>? coupon,}){
    _banners = banners;
    _serviceUsers = serviceUsers;
    _projects = projects;
    _cheapProjects = cheapProjects;
    _nearbyServiceUsers = nearbyServiceUsers;
    _recommendServiceUsers = recommendServiceUsers;
    _coupon = coupon;
}

  MainDataResponse.fromJson(dynamic json) {
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners?.add(BannerModel.fromJson(v));
      });
    }
    if (json['service_users'] != null) {
      _serviceUsers = [];
      json['service_users'].forEach((v) {
        _serviceUsers?.add(ServiceUsers.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      _projects = [];
      json['projects'].forEach((v) {
        _projects?.add(Projects.fromJson(v));
      });
    }
    _cheapProjects = json['cheap_projects'] != null ? json['cheap_projects'].cast<num>() : [];
    _nearbyServiceUsers = json['nearby_service_users'] != null ? json['nearby_service_users'].cast<num>() : [];
    _recommendServiceUsers = json['recommend_service_users'] != null ? json['recommend_service_users'].cast<num>() : [];
    if (json['coupon'] != null) {
      _coupon = [];
      json['coupon'].forEach((v) {
        _coupon?.add(Coupon.fromJson(v));
      });
    }
  }
  List<BannerModel>? _banners;
  List<ServiceUsers>? _serviceUsers;
  List<Projects>? _projects;
  List<num>? _cheapProjects;
  List<num>? _nearbyServiceUsers;
  List<num>? _recommendServiceUsers;
  List<Coupon>? _coupon;
MainDataResponse copyWith({  List<BannerModel>? banners,
  List<ServiceUsers>? serviceUsers,
  List<Projects>? projects,
  List<num>? cheapProjects,
  List<num>? nearbyServiceUsers,
  List<num>? recommendServiceUsers,
  List<Coupon>? coupon,
}) => MainDataResponse(  banners: banners ?? _banners,
  serviceUsers: serviceUsers ?? _serviceUsers,
  projects: projects ?? _projects,
  cheapProjects: cheapProjects ?? _cheapProjects,
  nearbyServiceUsers: nearbyServiceUsers ?? _nearbyServiceUsers,
  recommendServiceUsers: recommendServiceUsers ?? _recommendServiceUsers,
  coupon: coupon ?? _coupon,
);
  List<BannerModel>? get banners => _banners;
  List<ServiceUsers>? get serviceUsers => _serviceUsers;
  List<Projects>? get projects => _projects;
  List<num>? get cheapProjects => _cheapProjects;
  List<num>? get nearbyServiceUsers => _nearbyServiceUsers;
  List<num>? get recommendServiceUsers => _recommendServiceUsers;
  List<Coupon>? get coupon => _coupon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_banners != null) {
      map['banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    if (_serviceUsers != null) {
      map['service_users'] = _serviceUsers?.map((v) => v.toJson()).toList();
    }
    if (_projects != null) {
      map['projects'] = _projects?.map((v) => v.toJson()).toList();
    }
    map['cheap_projects'] = _cheapProjects;
    map['nearby_service_users'] = _nearbyServiceUsers;
    map['recommend_service_users'] = _recommendServiceUsers;
    if (_coupon != null) {
      map['coupon'] = _coupon?.map((v) => v.toJson()).toList();
    }
    return map;
  }


}