import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_split/controllers/password_controller.dart';
import 'package:screen_split/pages/main_page.dart';
import 'package:screen_split/theme/text_theme.dart';

class ChangePasswordPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(20.sp),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              'assets/icons/chevron_left.svg',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Container(
            color: const Color(0xff252525),
            child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Spacer(),
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
                                              'Change password',
                                              style: font28.copyWith(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              )
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                ))
        ),
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

  ExplanationPage({Key? key, required this.title, required this.description, required this.localImages, required this.isLastPage}) : super(key: key);

  TextEditingController passwordTextController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  PasswordController passwordController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/icons/password_icon.svg',
                alignment: Alignment.center,
                // height: localImages.length == 1 ? 252.h : 128.h,
                width: 52.sp,
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Text(
                'Please enter your current password',
                textAlign: TextAlign.center,
                style: font28.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
            Obx(() => Padding(
              padding: EdgeInsets.all(66.w),
              child: InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(passwordNode);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 28.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        passwordController.password.value.length > 0 ? passwordController.password.value[0] : '_',
                        style: font16.copyWith(
                            fontSize: 30.sp,
                            color: Color(0xff252525)
                        ),
                      ),
                      Text(
                        passwordController.password.value.length > 1 ? passwordController.password.value[1] : '_',
                        style: font16.copyWith(
                            fontSize: 30.sp,
                            color: Color(0xff252525)
                        ),
                      ),
                      Text(
                        passwordController.password.value.length > 2 ? passwordController.password.value[2] : '_',
                        style: font16.copyWith(
                            fontSize: 30.sp,
                            color: Color(0xff252525)
                        ),
                      ),
                      Text(
                        passwordController.password.value.length > 3 ? passwordController.password.value[3] : '_',
                        style: font16.copyWith(
                          fontSize: 30.sp,
                          color: Color(0xff252525)
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),)
          ],
        ),
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 4,
          controller: passwordTextController,
          focusNode: passwordNode,
          onChanged: (txt){
            passwordController.password(txt);
          },
        ),
      ],
    );
  }
}

