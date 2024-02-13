import 'dart:async';
import 'package:image_picker/image_picker.dart';

/**
 *  图片
 */

class PhotoTool {

  /*
  * 调用系统相册
  * int gallery:  0: 从相册选则  1：拍摄
  * */
  Future<XFile?> showImagePicker(int gallery) async {

    XFile? image;

    if(gallery == 0){
      image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 5);
    }
    else{
      image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 5);
    }

    return image;

  }



}

