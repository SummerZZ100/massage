
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/ad_tool/model/advert_box.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import 'package:webview_flutter/webview_flutter.dart';
/**
 *  广告弹框
 */


class AdvertWidget extends StatefulWidget {


  AdvertBox? advertBox;

  AdvertWidget({Key? key,this.advertBox}) : super(key: key);

  @override
  State<AdvertWidget> createState() => _AdvertWidgetState();

}

class _AdvertWidgetState extends State<AdvertWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double widgetWidth = double.parse(widget.advertBox?.width ?? '300');
    double widgetHeight = double.parse(widget.advertBox?.height ?? '300');

    return Material(//创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center( //保证控件居中效果
        child: Container(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widgetWidth,
                    height: widgetHeight,
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,//js调用方式
                      initialUrl: widget.advertBox?.url ?? '', // 加载的url
                      onProgress: (int progress){// 加载进度
                      },
                      onWebViewCreated: (WebViewController web) {//创建webview

                        // _controller = web;

                      },
                      onPageFinished: (String value) {
                      },
                      // javascriptChannels: <JavascriptChannel>{
                      //
                      // },
                      onPageStarted: (String url){
                        print('onPageStarted  url  = $url');
                      },
                      // navigationDelegate: (NavigationRequest request){// NavigationDecision.navigate:允许导航发生
                      //
                      // },
                      // userAgent: '',
                    ),
                  ),
                  SizedBox(height: 20.r,),
                  TapContainer(
                    childWidget: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        color: Colors.black87
                      ),
                      child:const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    clickBlock: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
      ),
    );

  }


}


