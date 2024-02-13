import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';


class LoadingProgress extends StatelessWidget {

  double? viewWidth;//视图宽度
  double? viewHeight;//视图高度

  LoadingProgress({Key? key, this.viewWidth,this.viewHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {//构建视图

    return Container(
      width: viewWidth ?? MediaQuery.of(context).size.width,
      height: viewHeight ?? MediaQuery.of(context).size.height,
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      alignment: AlignmentDirectional.center,
      child: Container(
          alignment: Alignment.center,
          child: _loadingStyleWidget()
      ),
    );

  }

  _loadingStyleWidget(){
    return const NutsActivityIndicator(
      radius: 18,
      tickCount: 15,
      activeColor: Colors.blueAccent,
      inactiveColor: Colors.black45,
      animationDuration: Duration(milliseconds: 600),
      relativeWidth: 0.5,
    );
  }


}