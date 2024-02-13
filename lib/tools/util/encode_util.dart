
import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';


/*
* 数据加密/解密工具类
* */
class EncodeUtil {

  static EncodeUtil? _instance;
  factory EncodeUtil() => _getInstance()!;
  static EncodeUtil? get instance => _getInstance();

  static EncodeUtil? _getInstance(){
    _instance ??= EncodeUtil._privateConstructor();
    return _instance;
  }

  EncodeUtil._privateConstructor();

  /*
  * Md5加密
  * */
  String generateMd5(String data) {

    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /*
  * Base64加密
  */
  String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  /*
  * 通过图片路径或文件将图片转换成Base64字符串
  */
  Future<String> imageToBase64({File? file,String? path}) async {
    if(path != null){
      File file = File(path);
      List<int> imageBytes = await file.readAsBytes();
      return base64Encode(imageBytes);
    }
    else{
      if(file != null){
        List<int> imageBytes = await file.readAsBytes();
        return base64Encode(imageBytes);
      }
    }
    return '';
  }


}