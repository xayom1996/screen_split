import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screen_split/pages/onboarding_page.dart';
import 'package:screen_split/theme/text_theme.dart';

class SplashPage extends StatefulWidget{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  RxBool show = true.obs;

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer(){
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(),
        ),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: Color(0xff6921C6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/splash_illustration.png',
                  alignment: Alignment.center,
                  height: 160.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: Text(
                  'Split Screen: Multitasking app',
                  textAlign: TextAlign.center,
                  style: font28.copyWith(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}