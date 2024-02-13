import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massage/middle/system_config.dart';

import '../../../middle/user_data_tool/user_data_local_tool.dart';

///  create by zhangxiaosong on 2023/9/16
///  describtion 

class HeaderEditCell extends StatelessWidget {



  HeaderEditCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.r,
      padding: EdgeInsets.only(left: 16.r,right: 14.r),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Text(
                  '头像',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                )),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  child: Container(
                    width: 24.r,
                    height: 24.r,
                    color: Colors.white,
                    child: UserDataLocalTool.instance.obtainHeader().isNotEmpty ? Image.memory(
                        Uint8List.fromList(UserDataLocalTool.instance.obtainHeader()),
                        fit: BoxFit.cover,
                      width: 24.r,
                      height: 24.r,
                    ) : Image.asset(
                      "${SystemConfig.resource}touxiang.png",
                      width: 24.r,
                      height: 24.r,
                    ),
                  ),
                ),
                SizedBox(width: 10.r,),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF333333),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFFEAEAEA),
          )
        ],
      ),
    );
  }
}
