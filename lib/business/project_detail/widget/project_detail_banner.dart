
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import '../../../tools/widgets/network_image/image_widget_zh.dart';
import '../logic/project_detail_banner_logic.dart';

/**
 *  首页 - banner
 */

class ProjectDetailBanner extends StatefulWidget {

  List<String> banners;//banner列表
  ProjectDetailBanner({Key? key,required this.banners}) : super(key: key);

  @override
  State<ProjectDetailBanner> createState() => _ProjectDetailBannerState();

}

class _ProjectDetailBannerState extends State<ProjectDetailBanner> {

  late ProjectDetailBannerLogic bannerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerController = Get.put(ProjectDetailBannerLogic());
  }

  @override
  void dispose() {
    bannerController.dispose();
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
    double bannerHeight = 200.r;

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
                String pic = widget.banners[index];
                return ImageWidgetZH(
                  imageUrl: pic,
                  imageWidth: bannerWidth,
                  imageHeight: bannerHeight,
                  style: 1,
                  fit:BoxFit.cover,
                );
              }
              else{
                return Container();
              }

            },
          ),
        ),
        Positioned(
          right: 18.r,
          bottom: 18.r,
          child: _bannerTitleWidget(),
        )
      ],
    );

  }
  /*
    * banner标题
    * */
  _bannerTitleWidget(){

   return GetBuilder<ProjectDetailBannerLogic>(
        id: bannerController.selectedIndexStatus,
        builder: (controller){
          if(widget.banners.length > 1){
            return  Container(
              height: 20.r,
              padding: EdgeInsets.only(left: 15.r,right: 15.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: Colors.black45
              ),
              alignment: Alignment.center,
              child: Text(
                '${bannerController.selectedIndex + 1}/${widget.banners.length}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            );
          }
          else{
            return const SizedBox();
          }
        });
  }

}


