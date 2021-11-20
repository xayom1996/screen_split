import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/pages/favorites.dart';
import 'package:screen_split/theme/text_theme.dart';

class CustomDialog extends StatelessWidget{
  final Function onSwapScreens;
  final Function onScreenShot;
  CustomDialog({Key? key, required this.onSwapScreens, required this.onScreenShot}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Container(
        width: 0.9.sw,
        child: Column(
          children: [
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
                child: CupertinoActionSheetAction(
                  child: Text('Add to favorites', style: font16),
                  onPressed: () {
                    mainController.isOpenMenu(false);
                    if (mainController.urls[1]!.value != '' || mainController.urls[2]!.value != '') {
                      mainController.isAddToFavorite(true);
                    }
                  },
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
                child: CupertinoActionSheetAction(
                  child: Text('Open favorites', style: font16),
                  onPressed: () {
                    mainController.isOpenMenu(false);
                    Get.to(Favorites());
                  },
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
                child: CupertinoActionSheetAction(
                  child: Text('Take a screenshot', style: font16),
                  onPressed: () async {
                    mainController.isOpenMenu(false);
                    await onScreenShot();
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.sp),
                  bottomLeft: Radius.circular(15.sp),
                ),
                color: const Color(0xff383838).withOpacity(0.9),
              ),
              child: CupertinoActionSheetAction(
                child: Text('Swap screens', style: font16),
                onPressed: () {
                  mainController.isOpenMenu(false);
                  onSwapScreens();
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                color: const Color(0xff383838).withOpacity(0.9),
              ),
              child: CupertinoActionSheetAction(
                child: Text('Cancel', style: font16.copyWith(color: Color(0xff39F06D)),),
                onPressed: () {
                  mainController.isOpenMenu(false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}