import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../middle/color_value.dart';
import '../../middle/system_config.dart';

/**
 *  空页面
 */

typedef NullDataWidgetBlock = Function();

class NullDataWidget extends StatelessWidget {

  String? logoPath;//logo图片地址
  String? alertTitle;//描述信息
  String? btnTitle;//按钮文字

  NullDataWidgetBlock? block;

  NullDataWidget({Key? key, this.logoPath,this.alertTitle,this.btnTitle,this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            logoPath ?? '${SystemConfig.resource}a-nullcase-line.png',
          ),
          SizedBox(height: 12.w,),
          Text(
            alertTitle ?? '暂无数据',
            style: TextStyle(
                color: ColorValue.textColor3(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 23.w,),
          Offstage(
            offstage: block == null,
            child: Center(
              child: TapContainer(
                childWidget: Container(
                  width: 200.w,
                  height: 40.w,
                  color: ColorValue.blueColor(),
                  alignment: Alignment.center,
                  child: Text(
                    btnTitle ?? '重新请求',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                clickBlock: (){
                  if(block != null){
                    block!();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );

  }

}

