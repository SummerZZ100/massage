/*
* 定义一些公用的小wiget
* */
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class RefreshWidgetZH {


/*
* 下拉刷新后，完成的提示视图
* */
  static Widget waterDropHeaderCompleteWidget(String title){

    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: const Color.fromARGB(255, 51, 51, 51),
        ),
        textAlign: TextAlign.center,
      ),
    );

  }


/*
* 上推加载更多/下拉刷新 视图
* */
  static smartRefreshListView({required RefreshController controller,ScrollController? scrollController,VoidCallback? onRefresh,
    VoidCallback? onLoading,Widget? child,bool? enablePullDown,bool? enablePullUp}){

    return SmartRefresher(
      enablePullDown: enablePullDown ?? true,
      enablePullUp: enablePullUp ?? true,
      header: WaterDropHeader(
        complete: RefreshWidgetZH.waterDropHeaderCompleteWidget('刷新成功'),
      ),
      footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode){
            Widget body;
            if(mode == LoadStatus.idle){
              body =  Text(
                "上拉加载",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
              );
            }
            else if(mode==LoadStatus.loading){
              body =  const CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("加载失败！点击重试！",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),);
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("松手,加载更多!",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),);
            }
            else{
              body = Text("没有更多数据了",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),);//没有更多数据了!
            }
            return SizedBox(
              height: 55.r,
              child: Center(child:body),
            );
          }),
      onRefresh: onRefresh,
      controller: controller,
      onLoading: onLoading,
      scrollController: scrollController,
      child: child,
    );

  }

}




