class MessageModel {
  MessageModel({
      this.createTime, 
      this.title, 
      this.detail, 
      this.readed,
      this.type});

  MessageModel.fromJson(dynamic json) {
    createTime = json['createTime'];
    title = json['title'];
    detail = json['detail'];
    readed = json['readed'];
    type = json['type'];
  }

  String? createTime;
  String? title;
  String? detail;
  bool? readed;
  int? type;// 1: 发送方  2:接收方

MessageModel copyWith({  String? createTime,
  String? title,
  String? detail,
  bool? readed,
  int? type
}) => MessageModel(  createTime: createTime ?? this.createTime,
  title: title ?? this.title,
  detail: detail ?? this.detail,
  readed: readed ?? this.readed,
  type: type ?? this.type
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createTime'] = createTime;
    map['title'] = title;
    map['detail'] = detail;
    map['readed'] = readed;
    map['type'] = type;
    return map;
  }

}