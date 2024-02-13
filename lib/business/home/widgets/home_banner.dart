
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:massage/tools/widgets/tap_container.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../logic/home_banner_logic.dart';
import '../models/BannerModel.dart';

/**
 *  首页 - banner
 */

typedef HomeBannerBlock = Function(BannerModel banner);

class HomeBanner extends StatefulWidget {

  List<BannerModel> banners;//banner列表
  HomeBannerBlock block;
  HomeBanner({Key? key,required this.banners,required this.block}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();

}

class _HomeBannerState extends State<HomeBanner> {

  late HomeBannerLogic bannerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerController = Get.put(HomeBannerLogic());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return _bannerWidget();

  }

  /*
  * 动图
  * */
  _bannerWidget(){
    bannerController.selectedIndex = 0;

    double bannerWidth = ScreenUtil().screenWidth;
    double bannerHeight = 150.r;

    return Stack(
      children: [
        Container(
          height: bannerHeight,
          width: bannerWidth,
          alignment: Alignment.center,
          child: Swiper(
            key: UniqueKey(),
            itemCount: (widget.banners.length),
            autoplay: (widget.banners.length) > 1 ? true : false,
            autoplayDelay: 5000,
            scrollDirection: Axis.horizontal,
            loop: (widget.banners.length) > 1 ? true : false,
            onIndexChanged: (int index){
              bannerController.changeSelectedIndex(index);
            },
            itemBuilder: (BuildContext context, int index) {

              if(index >= 0 && index < (widget.banners.length)){
                BannerModel pic = widget.banners[index];
                return TapContainer(
                  childWidget: ImageWidgetZH(
                    imageUrl: pic.imgSrc ?? "",
                    imageWidth: bannerWidth,
                    imageHeight: bannerHeight,
                    style: 1,
                    fit:BoxFit.fill,
                  ),
                  clickBlock: (){

                    widget.block(pic);

                  },
                );
              }
              else{
                return Container();
              }

            },
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: _bannerTitleWidget(),
        )
      ],
    );

  }
  /*
    * banner标题
    * */
  _bannerTitleWidget(){

   return GetBuilder<HomeBannerLogic>(
        id: bannerController.selectedIndexStatus,
        builder: (controller){

          double bannerWidth = ScreenUtil().screenWidth;

          if(widget.banners.length > 1){
            return  Container(
              width: bannerWidth,
              height: 10.w,
              padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 15.w),
              alignment: Alignment.center,
              child: Wrap(
                spacing: 6.w,
                runSpacing: 2.w,
                children: _wrapWidgets(),
              ),
            );
          }
          else{
            return const SizedBox();
          }
        });
  }

  _wrapWidgets(){

    List<Widget> list = [];

    for(int i = 0;i < (widget.banners.length);i++){
      list.add(Container(
        width: 8.r,
        height: 8.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          border: Border.all(color: Colors.blueAccent, width: 1),
          color:bannerController.selectedIndex == i ? Colors.blueAccent
              : Colors.white,
        ),
      ));
    }

    return list;

  }

}


