import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screen_split/theme/text_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        title: Text('Settings', style: font28),
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
      body: Padding(
        padding: EdgeInsets.only(left: 16.sp, right: 16.sp, top: 30.sp),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                color: const Color(0xff383838).withOpacity(0.9),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 18.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Change password', style: font16),
                    SvgPicture.asset(
                      'assets/icons/chevron_right.svg',
                      width: 8.w,
                      color: Color(0xffE7E7E7),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Color(0xff383838)),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.sp),
                    topLeft: Radius.circular(15.sp),
                  ),
                  color: const Color(0xff383838).withOpacity(0.9),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 18.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Term of use', style: font16),
                      SvgPicture.asset(
                        'assets/icons/chevron_right.svg',
                        width: 8.w,
                        color: Color(0xffE7E7E7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Color(0xff383838)),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff383838).withOpacity(0.9),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 18.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Privacy policy', style: font16),
                      SvgPicture.asset(
                        'assets/icons/chevron_right.svg',
                        width: 8.w,
                        color: Color(0xffE7E7E7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff383838).withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.sp),
                  bottomLeft: Radius.circular(15.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 18.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Support', style: font16),
                    SvgPicture.asset(
                      'assets/icons/chevron_right.svg',
                      width: 8.w,
                      color: Color(0xffE7E7E7),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}