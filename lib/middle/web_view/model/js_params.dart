
import '../../../business/create_order/model/Create_order_alipay_response.dart';
import '../../../business/create_order/model/Create_order_wechat_response.dart';

class JsParams {
  JsParams({
      this.type, 
      this.taskTitle, 
      this.taskLabel, 
      this.url,
      this.sign,
      this.aliSign,
  });

  JsParams.fromJson(dynamic json) {
    type = json['type'];
    taskTitle = json['task_title'];
    taskLabel = json['task_label'];
    url = json['url'];
    sign = json['sign'] != null ? CreateOrderWechatResponse.fromJson(json['sign']) : null;
    aliSign = json['aliSign'] != null ? CreateOrderAlipayResponse.fromJson(json['aliSign']) : null;
  }

  static String jsonFromErrorJson(String errorJson) {
    
    String jsonStr = errorJson.replaceAll('{', '{"');
    jsonStr = jsonStr.replaceAll('}', '"}');
    jsonStr = jsonStr.replaceAll(",", '","');
    jsonStr = jsonStr.replaceAll(':', '":"');
    jsonStr = jsonStr.replaceAll('http":"', 'http:');
    jsonStr = jsonStr.replaceAll('https":"', 'https:');

    jsonStr = jsonStr.replaceAll(' ', '');
    print('===== js $jsonStr');

    return jsonStr;

  }

  String? type;
  String? taskTitle;
  String? taskLabel;
  String? url;
  CreateOrderWechatResponse? sign;
  CreateOrderAlipayResponse? aliSign;

JsParams copyWith({  String? type,
  String? taskTitle,
  String? taskLabel,
  String? url,
}) => JsParams(  type: type ?? this.type,
  taskTitle: taskTitle ?? this.taskTitle,
  taskLabel: taskLabel ?? this.taskLabel,
  url: url ?? this.url,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['task_title'] = taskTitle;
    map['task_label'] = taskLabel;
    map['url'] = url;
    if (sign != null) {
      map['sign'] = sign?.toJson();
    }
    if (aliSign != null) {
      map['aliSign'] = aliSign?.toJson();
    }
    return map;
  }

}