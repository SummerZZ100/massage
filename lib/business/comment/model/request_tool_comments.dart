import 'dart:convert';

import 'package:massage/business/address/model/Contact_address_list.dart';
import 'package:massage/business/address/model/Contact_address_model.dart';
import 'package:massage/business/comment/model/comment_list.dart';
import 'package:massage/business/comment/model/comment_model.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';

///  describtion

class RequestToolComments {

  static final RequestToolComments _instance = RequestToolComments();
  static RequestToolComments get instance => _instance;

  /*
  * 获取评价列表
  * */
  Future<List<CommentModel>> getCommentList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonStr = preferences.getString('${UserDataLocalTool.instance.obtainKey()}_comment_list');
    List<CommentModel> list = [];
    if((jsonStr?.length ?? 0) > 0){
      CommentList commentList = CommentList.fromJson(jsonDecode(jsonStr!));
      list.addAll(commentList.commentList ?? []);
    }
    return list;
  }

  clearCommentList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_comment_list',"");
  }

  /*
  * 保存评价列表
  * */
  saveCommentList({required CommentList commentList}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool success = await preferences.setString('${UserDataLocalTool.instance.obtainKey()}_comment_list',
     jsonEncode(commentList.toJson()));
  }

  /*
  *  添加评论
  * */
  Future<List<CommentModel>> addComment({required CommentModel model}) async {
    List<CommentModel> list = await getCommentList();
    list.insert(0, model);
    await saveCommentList(commentList: CommentList(commentList: list));
    return list;
  }




}