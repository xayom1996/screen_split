import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_bindings.dart';
import 'package:screen_split/pages/main_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: appThemeData[AppTheme.RedDark],
        // darkTheme: appThemeData[AppTheme.RedDark],
        title: "Split Screen",
        initialBinding: MainBinding(),
        home: const MainPage(),
      ),
    );
  }
}