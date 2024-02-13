/*
@describe 接口请求封装类
**/

/*
* 组织好的请求数据
* */

class RequestOrgModel{

  Map<String,dynamic>? requestJson;//请求参数
  String requestUrl;//请求接口

  /*
  * 构造方法　
  * */
  RequestOrgModel({this.requestJson,this.requestUrl = ''});

}