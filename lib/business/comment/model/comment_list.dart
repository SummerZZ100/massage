

import 'package:massage/business/comment/model/comment_model.dart';

class CommentList {

  CommentList({
      this.commentList,});

  CommentList.fromJson(dynamic json) {
    if (json['commentList'] != null) {
      commentList = [];
      json['commentList'].forEach((v) {
        commentList?.add(CommentModel.fromJson(v));
      });
    }
  }

  List<CommentModel>? commentList;

  CommentList copyWith({  List<CommentModel>? commentList,
}) => CommentList(  commentList: commentList ?? this.commentList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (commentList != null) {
      map['commentList'] = commentList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}