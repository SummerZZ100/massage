/*
@Date: 2020/7/1
@describe 接口请求封装类
**/

/*
* 组织好的请求数据
* */

class RequestInterfaceModel{

  Map<String,dynamic>? requestJson;//请求参数

  String requestUrl;//请求接口


  /*
  * 构造方法　
  * */
  RequestInterfaceModel({this.requestJson,this.requestUrl = ''});

}