class ReportContentModel {
  ReportContentModel({
      this.title, 
      this.selected,});

  ReportContentModel.fromJson(dynamic json) {
    title = json['title'];
    selected = json['selected'];
  }
  String? title;
  bool? selected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['selected'] = selected;
    return map;
  }

}