import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';
import 'package:massage/tools/widgets/tap_container.dart';

///  describtion


typedef SortTitleWidgetBlock = Function();

class SortTitleWidget extends StatelessWidget {

  String sortName;
  SortTitleWidgetBlock block;

  SortTitleWidget({super.key,required this.sortName,required this.block});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TapContainer(childWidget: Text(
            "$sortName ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: const Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),clickBlock: (){
            block();
          },),
          Image.asset(
            "${SystemConfig.resource}up_down.png"
          )
        ],
      ),

    );
  }
}
