
/*
* 网络请求管理类
* */
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';

class NetworkManagerZH
{

  //工厂模式
  static final NetworkManagerZH _instance = NetworkManagerZH();
  static NetworkManagerZH get instance => _instance;


  /*
  * 设置基础请求信息
  * */
  BaseOptions obtainBaseOptions()
  {

    BaseOptions baseOptions = BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
      contentType: 'application/json',
    );

    return baseOptions;

  }

  /*
  * post请求发送
  * path : 网络请求地址
  * */
  Future post(String path, {Map<String, dynamic>? queryParameters, Options? options,
    CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress,
  }) async {

    String jsonStr = json.encode(queryParameters);
    debugPrint('URL:  $path \nREQUEST:   $jsonStr');

    DioForNative dio = DioForNative();

    dio.options.contentType = 'application/json';
    dio.options.receiveTimeout = 20000;
    dio.options.connectTimeout = 20000;
    dio.options.responseType = ResponseType.json;
    dio.options.extra = {'accept': 'application/json'};

    debugPrint('Headers = ${dio.options.headers}');

    Response response;

    try{
      response = await dio.post(path,queryParameters: queryParameters);
    }
    on DioError catch (e){
      debugPrint(e.message);
      toast(e.message);
      return null;
    }

    if(response.statusCode == 200){//成功
      if(response.data != null && response.data.length > 0){

        debugPrint('response Data ${response.toString()}');
        return response.data;

      }
      else{
        return null;
      }
    }
    else{
      toast('获取数据失败');
      return null;
    }

  }

  /*
  * post formData 请求发送
  * path : 网络请求地址
  * */
  Future postFormData(String path, {required Map<String, dynamic> data, Options? options,
    CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress,
  }) async {

    String jsonStr = json.encode(data);

    debugPrint('URL:  $path \nREQUEST:   $jsonStr');

    DioForNative dio = DioForNative();

    dio.options.contentType = 'application/json';
    dio.options.receiveTimeout = 20000;
    dio.options.connectTimeout = 20000;
    dio.options.responseType = ResponseType.json;
    dio.options.extra = {'accept': 'application/json'};

    debugPrint('Headers = ${dio.options.headers}');

    Response response;

    try{
      FormData formData = FormData.fromMap(data);
      response = await dio.post(path,data: formData);
    }
    on DioError catch (e){
      debugPrint(e.message);
      toast(e.message);
      return null;
    }

    if(response.statusCode == 200){//成功
      if(response.data != null && response.data.length > 0){

        debugPrint('response Data ${response.toString()}');
        return response.data;

      }
      else{
        return null;
      }
    }
    else{
      toast('获取数据失败');
      return null;
    }

  }


  /*
  * get请求发送
  * path : 网络请求地址
  *
  * */
  Future get(String path) async {

    DioForNative dio = DioForNative();

    dio.options.contentType = 'application/json';
    dio.options.receiveTimeout = 20000;
    dio.options.connectTimeout = 20000;
    dio.options.responseType = ResponseType.json;
    dio.options.extra = {'accept': 'application/json'};

    Response response;

    debugPrint("=== request == $path");

    try{
      response = await dio.get(path);
    }
    on DioError catch (e){
      debugPrint(e.message);
      return null;
    }

    debugPrint('=== request == $path'
        ' \n response ${response.toString()}');

    if(response.statusCode == 200){//成功
      return response.data;
    }
    else{
      toast('获取数据失败');
      return null;
    }

  }




}