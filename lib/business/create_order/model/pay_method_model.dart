
class PayMethodModel {

  PayMethodModel({
      this.icon, 
      this.type, 
      this.title, 
      this.mark, 
      this.selected,});

  PayMethodModel.fromJson(dynamic json) {
    icon = json['icon'];
    type = json['type'];
    title = json['title'];
    mark = json['mark'];
    selected = json['selected'];
  }

  String? icon;//支付方式logo
  int? type;//支付方式  1：支付宝  2：微信 
  String? title;//支付方式名称
  String? mark;//描述
  bool? selected;//是否选中

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['type'] = type;
    map['title'] = title;
    map['mark'] = mark;
    map['selected'] = selected;
    return map;
  }


}