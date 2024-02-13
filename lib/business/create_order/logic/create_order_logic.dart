
import 'package:get/get.dart';
import 'package:massage/business/address/model/Contact_address_model.dart';
import 'package:massage/business/create_order/model/Create_order_alipay_response.dart';
import 'package:massage/business/create_order/model/Create_order_wechat_response.dart';
import 'package:massage/business/home/models/Projects.dart';
import 'package:massage/business/home/models/ServiceUsers.dart';
import '../../../middle/network/request_interface.dart';
import '../../../middle/user_data_tool/user_data_local_tool.dart';
import '../../../tools/util/network_manager_zh.dart';


///  create by zhangxiaosong on 2023/9/9
///  describtion 

class CreateOrderLogic extends GetxController{

  Projects project;
  ServiceUsers serviceUsers;
  int serviceItem;
  int number;

  String address = '';
  String detailAddress = '';
  String contactName = '';
  String contactPhone = '';
  String sex = '先生';
  bool netLoading = false;
  DateTime? serviceTime;//服务时间
  int payType = 2;//1:支付宝 2:微信

  final contactNotifyId = 'contactNotifyId';
  final serviceNotifyId = 'serviceNotifyId';
  final numNotifyId = 'numNotifyId';
  final bottomNotifyId = 'bottomNotifyId';
  final loadingNotifyId = 'loadingNotifyId';
  final payMethodNotifyId = 'payMethodNotifyId';

  CreateOrderLogic({required this.project,required this.serviceUsers,required this.serviceItem,required this.number});

  /*
  * 修改支付方式
  * */
  changePayMethod(int type){

    payType = type;

    update([payMethodNotifyId]);

  }

  changeAddress(String text){
    address = text;
  }

  changeDetailAddress(String text){
    detailAddress = text;
  }

  changeContactName(String text){
    contactName = text;
  }

  changeSex(String text){
    sex = text;
    update([contactNotifyId]);
  }

  changePhone(String text){
    contactPhone = text;
  }

  changeCA(ContactAddressModel model){
     address = model.city ?? '';
     detailAddress = model.addressDetail ?? "";
     contactName = model.contactName ?? "";
     contactPhone = model.contactPhone ?? "";
     sex = model.sex ?? "";
     update([contactNotifyId]);
  }

  changeNumber(int num){
    number = num;
    update([numNotifyId,bottomNotifyId]);
  }

  changeServiceTime(DateTime dateTime){
    serviceTime = dateTime;
    update([serviceNotifyId]);
  }

  // requestCreateOrder(Function? success) async {
  //
  //   int count = Random().nextInt(2);
  //   while (count == 0){
  //     count = Random().nextInt(2);
  //   }
  //
  //   count = count * 2;
  //
  //   netLoading = true;
  //   update([loadingNotifyId]);
  //
  //   DateTime now = DateTime.now();
  //   String nowTimeStr = '$now';
  //   if(nowTimeStr.length > 19){
  //     nowTimeStr = nowTimeStr.substring(0,18);
  //   }
  //
  //   String serviceTimeStr = '';
  //     String hourStr = '';
  //     if(serviceTime!.hour <= 9){
  //       hourStr = '0${serviceTime!.hour}';
  //     }
  //     else{
  //       hourStr = '${serviceTime!.hour}';
  //     }
  //     String minuteStr = '';
  //     if(serviceTime!.minute <= 9){
  //       minuteStr = '0${serviceTime!.minute}';
  //     }
  //     else{
  //       minuteStr = '${serviceTime!.minute}';
  //     }
  //     serviceTimeStr = ' ${serviceTime!.month}月${serviceTime!.day}日  $hourStr:$minuteStr';
  //
  //   OrderModel orderModel = OrderModel(
  //     project: project,
  //     serviceUser: serviceUsers,
  //     serviceItem: serviceItem,
  //     number: number,
  //     address: address,
  //     detailAddress: detailAddress,
  //     contactName: contactName,
  //     contactPhone: contactPhone,
  //     sex: sex,
  //     serviceTime: serviceTimeStr,
  //     orderStatus: '1',
  //     createTime: '$now',
  //   );
  //
  //   await RequestToolOrder.instance.createOrder(model: orderModel);
  //
  //   Future.delayed(Duration(milliseconds: count*1000),(){
  //
  //     netLoading = false;
  //     update([loadingNotifyId]);
  //     if(success != null){
  //       success();
  //     }
  //   });
  //
  //
  // }

  /*
  * 请求创建订单
  * */
  requestCreateOrder({Function? success,Function? fail}){

    netLoading = true;
    update([loadingNotifyId]);

    RequestInterface.requestCreateOrder(
      key: UserDataLocalTool.instance.userInfo?.key,
      serviceUserId: serviceUsers.id,
      cateId: project.id,
      price: project.price,
      type: payType
    ).then((value) {

      NetworkManagerZH.instance.post(value).then((value){

        if(value != null){

          if(payType == 1){//支付宝支付
            CreateOrderAlipayResponse response = CreateOrderAlipayResponse.fromJson(value);
            if(response.code == 200 && response.data != null){
              if(success != null) {
                success(response.data);
              }
              else{
                if(fail != null){
                  fail(response.msg ?? "创建订单失败，请重新请求");
                }
              }
            }
          }
          else if(payType == 2){//微信支付 　
            CreateOrderWechatResponse response = CreateOrderWechatResponse.fromJson(value);
            if(response.code == 200 && response.data != null){
              if(success != null) {
                success(response.data);
              }
            }
            else{
              if(fail != null){
                fail(response.msg ?? "创建订单失败，请重新请求");
              }
            }
          }
        }

        netLoading = false;
        update([loadingNotifyId]);

      });

    });

  }

}