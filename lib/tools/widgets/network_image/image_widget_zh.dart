import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../loading_progress.dart';
import 'image_loading_zh.dart';

/**
 *  网络图片加载视图
 */


class ImageWidgetZH extends StatelessWidget {

  String? imageUrl;//图片路径
  double imageWidth;//图片宽度
  double imageHeight;//图片高度
  int style = 1;// 0:图片为空时不占位  1：图片为空时占位
  BoxFit? fit;
  double? radius;//圆角
  int? abbreviate;//是否缩略，缩略的倍数  1/0/空 ： 原图  2：1/2图   3：1/3图   4：1/4图
  double? aspectRatio;//图片宽高比
  Color? backgroundColor;

  ImageWidgetZH({Key? key, this.imageUrl,required this.imageWidth,
    required this.imageHeight,this.style = 1,required this.fit,this.radius,this.abbreviate,this.aspectRatio,this.backgroundColor}) : super(key: key){
    imageUrl ??= '';
    fit ??= BoxFit.cover;
    radius ??= 0.0;
    abbreviate ??= 1;
    aspectRatio ??= 1.0;
    backgroundColor ??= Colors.white;
  }

  @override
  Widget build(BuildContext context) {

    if(imageUrl!.contains('https')){

      if(radius! > 0){
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
          child: CachedNetworkImage(
            width: imageWidth,
            height: imageHeight,
            imageUrl: imageUrl!,
            fit: fit,
            placeholder: (bc,url){
              return ImageLoadingZH(width: imageWidth,height: imageHeight,
                backgroundColor: backgroundColor,
              );
            },
            errorWidget: (BuildContext bc,String url,dynamic error){
              return ImageLoadingZH(alertTitle: '图片加载失败',width: imageWidth,height: imageHeight,
              backgroundColor: backgroundColor,);
            },
          ),
        );
      }
      else{
        return CachedNetworkImage(
          width: imageWidth,
          height: imageHeight,
          imageUrl: imageUrl!,
          fit: fit,
          placeholder: (bc,url){
            return ImageLoadingZH(width: imageWidth,height: imageHeight,
              backgroundColor: backgroundColor,
            );
          },
          errorWidget: (BuildContext bc,String url,dynamic error){
            return ImageLoadingZH(alertTitle: '图片加载失败',width: imageWidth,height: imageHeight,
              backgroundColor: backgroundColor,
            );
          },
        );
      }

    }
    else {
      if(style == 1){
        return ImageLoadingZH(alertTitle: '暂无图片',width: imageWidth,
            height: imageHeight,backgroundColor: backgroundColor,);
      }
      else{
        return ImageLoadingZH(alertTitle: '暂无图片',width: imageWidth,
            height: imageHeight,backgroundColor: backgroundColor,);
      }
    }



  }

}


