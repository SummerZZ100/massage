
import 'package:get/get.dart';
import 'package:massage/business/comment/model/request_tool_comments.dart';

import '../model/comment_model.dart';

///  create by zhangxiaosong on 2023/9/8
///  describtion 

class CommentListLogic extends GetxController {

   List<CommentModel> list = [];
   final dataNotifyId = 'dataNotifyId';

   requestComments()async{

      list = await RequestToolComments.instance.getCommentList();
      await Future.delayed(const Duration(milliseconds: 300));

      update([dataNotifyId]);

   }

}