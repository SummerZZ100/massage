
import 'dart:math';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massage/business/comment/model/comment_model.dart';
import 'package:massage/business/comment/model/request_tool_comments.dart';
import 'package:massage/business/order/model/order_model.dart';

///  describtion

class CommentEditLogic extends GetxController {

   XFile? imageFile;
   String content = "";
   OrderModel orderModel;
   bool netLoading = false;

   final dataNotifyId = 'dataNotifyId';
   final loadingNotifyId = 'loadingNotifyId';

   CommentEditLogic({required this.orderModel});

   changeImage(XFile? image){
      imageFile = image;
      update([dataNotifyId]);
   }

   changeContent(String text){
      content = text;
   }


   requestCreateComment() async {

      netLoading = true;
      update([loadingNotifyId]);

     await RequestToolComments.instance.addComment(model: CommentModel(
        orderModel: orderModel,
        comment: content
     ));

      int count = 0;
      while (count == 0){
         count = Random().nextInt(2);
      }

     await Future.delayed(Duration(milliseconds: count*800));

      netLoading = false;
      update([loadingNotifyId]);

   }


}