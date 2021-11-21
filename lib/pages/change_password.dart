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
import 'package:screen_split/widgets/custom_snackbar.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  PasswordController passwordController = Get.find(tag: 'password');
  RxString status = 'enter'.obs;
  RxString password = ''.obs;

  FocusNode passwordNode = FocusNode();
  TextEditingController passTextController = TextEditingController();
  TextEditingController newpassTextController = TextEditingController();

  @override
  Widget build(BuildContext context){
    if (passwordController.password.value == '') {
      status('change');
    }

    return Scaffold(
      backgroundColor: Color(0xff252525),
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
        child: Obx(() => status.value != 'success'
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              status.value == 'enter'
                                  ? 'Please enter your current password'
                                  : 'Please enter  new password',
                              textAlign: TextAlign.center,
                              style: font28.copyWith(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Obx(() => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 66.w),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  child: SizedBox(
                                    width: 1.sw - 66.w,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      focusNode: passwordNode,
                                      controller: passTextController,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (txt){
                                        password(txt);
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
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
                                            password.value.length > 0 ? password.value[0] : '_',
                                            style: font16.copyWith(
                                                fontSize: 30.sp,
                                                color: Color(0xff252525)
                                            ),
                                          ),
                                          Text(
                                            password.value.length > 1 ? password.value[1] : '_',
                                            style: font16.copyWith(
                                                fontSize: 30.sp,
                                                color: Color(0xff252525)
                                            ),
                                          ),
                                          Text(
                                            password.value.length > 2 ? password.value[2] : '_',
                                            style: font16.copyWith(
                                                fontSize: 30.sp,
                                                color: Color(0xff252525)
                                            ),
                                          ),
                                          Text(
                                            password.value.length > 3 ? password.value[3] : '_',
                                            style: font16.copyWith(
                                                fontSize: 30.sp,
                                                color: Color(0xff252525)
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 56.sp),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          padding: EdgeInsets.all(16.sp),
                          onPressed: (){
                            if (password.value.length != 4){
                              passwordController.showSnackbar('Please enter four digits');
                            } else if (status.value == 'enter') {
                              if (password.value != passwordController.password.value){
                                passwordController.showSnackbar('Wrong password');
                              }
                              else {
                                password('');
                                passTextController.clear();
                                status('change');
                              }
                            } else if (status.value == 'change') {
                              status('success');
                              passwordController.changePassword(password.value);
                            }
                          },
                          color: Color(0xff00FF66),
                          child: Text(
                              status.value == 'enter'
                                  ? 'Enter password'
                                  : 'Change password',
                              style: font28.copyWith(
                                  fontSize: 20.sp,
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (passwordController.isSnackBarShowed.value)
                    Positioned(
                        bottom: 10.h,
                        child: CustomSnackbar(title: passwordController.snackBarTitle.value)
                    ),
                ],
              )
            : Center(
                child: Text(
                  'Successfully password changed',
                  textAlign: TextAlign.center,
                  style: font28.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff00FF66),
                  ),
                ),
              )
        )
      ),
    );
  }
}

