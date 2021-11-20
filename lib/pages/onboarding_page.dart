import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_split/pages/main_page.dart';
import 'package:screen_split/theme/text_theme.dart';

class OnBoardingPage extends StatelessWidget {
  final _controller = PageController();

  RxInt _currentIndex = 0.obs;

  final explanationPages = [
    ExplanationPage(
      title: 'Multitasking Split Screen',
      description: 'Quick switch between fullscreen and dual screen',
      localImages: ['assets/illustration_1.png'],
      isLastPage: false,
    ),
    ExplanationPage(
      title: 'Help us become better',
      description: 'Please let us know. We are looking for any feedback',
      localImages: ['assets/illustration_2.png'],
      isLastPage: false,
    ),
    ExplanationPage(
      title: 'Web Browser',
      description: 'Quick and easy access to your favorite websites and screens',
      localImages: ['assets/illustration_3.png'],
      isLastPage: false,
    ),
    ExplanationPage(
      title: 'Split Screen',
      description: 'Subscribe to unlock all the features, just \$3.99/w',
      localImages: ['assets/illustration_4.png'],
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Material(
      type: MaterialType.transparency,
      child: Container(
          color: Color(0xff6921C6),
          child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: PageView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    controller: _controller,
                                    onPageChanged: (value) {
                                      _currentIndex(value);
                                    },
                                    children: explanationPages,
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            // Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                // Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 56.sp),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.sp),
                                    ),
                                    padding: EdgeInsets.all(16.sp),
                                    onPressed: (){
                                      _controller.nextPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeInOut
                                      );
                                    },
                                    color: Color(0xff00FF66),
                                    child: Text(
                                      'Continue',
                                      style: font28.copyWith(
                                        fontSize: 20.sp,
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Terms of Use',
                                      textAlign: TextAlign.center,
                                      style: font14.copyWith(
                                        decoration: TextDecoration.underline,
                                      )
                                    ),
                                    Text(
                                      'Restore',
                                      textAlign: TextAlign.center,
                                      style: font14.copyWith(
                                        decoration: TextDecoration.underline,
                                      )
                                    ),
                                    Text(
                                      'Privacy policy',
                                      textAlign: TextAlign.center,
                                      style: font14.copyWith(
                                        decoration: TextDecoration.underline,
                                      )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 56.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
              ))
      ),
    );
  }

  createCircle({required int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 8.w),
        height: 8.w,
        width: 8.w, // current indicator is wider
        decoration: BoxDecoration(
          color: _currentIndex.value != index ? Color(0xffBDBDBD): Color(0xff6921C6),
          borderRadius: BorderRadius.circular(8.w),
        )
    );
  }
}

class ExplanationPage extends StatelessWidget{
  final String title;
  final String description;
  final List<String> localImages;
  final bool isLastPage;

  const ExplanationPage({Key? key, required this.title, required this.description, required this.localImages, required this.isLastPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLastPage)
          Positioned(
            top: 8.sp,
            left: 8.sp,
            child: IconButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                      (route) => false,
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.times,
                size: 18.sp,
                color: Colors.white,
                // #5B5B5B
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            for (var img in localImages)
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      img,
                      alignment: Alignment.center,
                      // height: localImages.length == 1 ? 252.h : 128.h,
                      width: 343.w,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            SizedBox(height: 30.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: font28.copyWith(
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: font14.copyWith(
                      fontSize: 18.sp,
                    )
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

