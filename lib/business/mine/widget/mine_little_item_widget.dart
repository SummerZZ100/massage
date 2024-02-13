import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  create by zhangxiaosong on 2023/9/10
///  describtion 

/*
* 回调方法
*
* */
typedef MineLittleItemWidgetBlock = Function();

class MineLittleItemWidget extends StatelessWidget {

  String title;
  MineLittleItemWidgetBlock block;
  MineLittleItemWidget({super.key,required this.block,required this.title});

  @override
  Widget build(BuildContext context) {

    return TapContainer(
      childWidget: Column(
        children: [
          Image.asset(
            _imagePath(),
          ),
          SizedBox(height: 5.r,),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          )
        ],
      ),
      clickBlock: (){
        block();
      },
    );
  }

  _imagePath(){

    String path = '';

    if(title == '待接单'){
      path = '${SystemConfig.resource}order_waite.png';
    }
    else if(title == '待服务'){
      path = '${SystemConfig.resource}order_service.png';
    }
    else if(title == '已完成'){
      path = '${SystemConfig.resource}order_check.png';
    }
    else if(title == '退款/售后'){
      path = '${SystemConfig.resource}order_back.png';
    }
    else if(title == '优惠券'){
      path = '${SystemConfig.resource}mine_coupon.png';
    }
    else if(title == '地址管理'){
      path = '${SystemConfig.resource}mine_address.png';
    }
    else if(title == '我的评价'){
      path = '${SystemConfig.resource}mine_comment.png';
    }
    else if(title == '使用手册'){
      path = '${SystemConfig.resource}mine_book.png';
    }
    else if(title == '在线客服'){
      path = '${SystemConfig.resource}mine_ai.png';
    }
    else if(title == '隐私政策'){
      path = '${SystemConfig.resource}mine_protocol.png';
    }
    else if(title == '设置'){
      path = '${SystemConfig.resource}mine_setting.png';
    }

    return path;

  }

}
