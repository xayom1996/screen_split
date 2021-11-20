import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_bindings.dart';
import 'package:screen_split/pages/main_page.dart';
import 'package:screen_split/pages/onboarding_page.dart';
import 'package:screen_split/pages/splash_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Split Screen",
          initialBinding: MainBinding(),
          home: SplashPage(),
        ),
      ),
    );
  }
}