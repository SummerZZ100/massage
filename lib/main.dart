import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:massage/middle/user_data_tool/user_data_local_tool.dart';
import 'package:massage/tools/util/shared_preference_zh.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'middle/router_manager.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();//应用开启状态监控

  await UserDataLocalTool.instance.readUserInfoFromSanBox();//读取用户信息
  await SharedPreferenceZH.instance.saveAppStartNumber();

  runApp(const MyApp());

}

/*
* 主应用
* */
class MyApp extends StatefulWidget {

  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static AppLifecycleState? appLifecycleState;

  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      return ScreenUtilInit(
          designSize: const Size(375, 667),
          builder: (BuildContext context, Widget? child) {
            return OverlaySupport.global(child: GetMaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale.fromSubtags(languageCode: 'zh'),
              ],
              title: '成人技师按摩保健',
              debugShowCheckedModeBanner: false,
              //去除debug标示
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  brightness: Brightness.light,
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    brightness: Brightness.light,
                  ),
                  backgroundColor: const Color(0xFFEAEAEA),
                  fontFamily: "PingFang_Regular",
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent
              ),
              navigatorObservers: <NavigatorObserver>[MyApp.routeObserver],
              getPages: RouterManager.routes,
              initialRoute: Routers.launch_page,
            ));
            });
  }

}