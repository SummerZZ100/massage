
class SortModel {

  SortModel({
      this.sortName, 
      this.selected,});

  SortModel.fromJson(dynamic json) {
    sortName = json['sortName'];
    selected = json['selected'];
  }

  String? sortName;
  bool? selected;

SortModel copyWith({  String? sortName,
  bool? selected,
}) => SortModel(  sortName: sortName ?? this.sortName,
  selected: selected ?? this.selected,
);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sortName'] = sortName;
    map['selected'] = selected;
    return map;
  }

}