import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/favorites.dart';
import 'package:screen_split/theme/text_theme.dart';
import 'package:screen_split/widgets/menu.dart';

class Toolbar extends StatelessWidget{
  final Function onSwapScreens;
  final Function onScreenShot;
  final Function addToFavorites;
  Toolbar({Key? key, required this.onSwapScreens, required this.onScreenShot,
    required this.addToFavorites}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');

  void _showMenu(BuildContext ctx) {
    toolbarController.isOpenMenu(true);

    showCupertinoModalPopup<void>(
        context: ctx,
        builder: (BuildContext context) => Align(
          alignment: Alignment.center,
          child: CupertinoActionSheet(
            actions: <Widget>[
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: Text('Add to favorites', style: font16),
                  onPressed: () {
                    Navigator.pop(context);
                    if (mainController.urls[1]!.value != '' || mainController.urls[2]!.value != '') {
                      mainController.isAddToFavorite(true);
                    }
                  },
                ),
              ),
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: Text('Open favorites', style: font16),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.to(Favorites());
                  },
                ),
              ),
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: Text('Take a screenshot', style: font16),
                  onPressed: () {
                    Navigator.pop(context);
                    onScreenShot();
                  },
                ),
              ),
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: Text('Swap screens', style: font16),
                  onPressed: () {
                    Navigator.pop(context);
                    onSwapScreens();
                  },
                ),
              ),
              // SizedBox(
              //   height: 12.h,
              // ),
              // Container(
              //   color: const Color(0xff383838).withOpacity(0.9),
              //   child: CupertinoActionSheetAction(
              //     child: Text('Cancel', style: TextStyle(color: Colors.green),),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
            ],
            cancelButton: Container(
              color: const Color(0xff383838).withOpacity(0.9),
              child: CupertinoActionSheetAction(
                child: Text('Cancel', style: font16.copyWith(color: Color(0xff39F06D)),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        )
    ).then((value) {
      toolbarController.isOpenMenu(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: (){
            toolbarController.clickedToolbarButton();
          },
          child: Container(
            height: 22.h,
            width: 49.w,
            padding: EdgeInsets.only(top: 10.h, left: 17.w, right: 17.w),
            decoration: BoxDecoration(
              color: const Color(0xff383838).withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.sp),
                  topLeft: Radius.circular(50.sp),
              ),
            ),
            child: InkWell(
              onTap: () {
                toolbarController.isOpen(!toolbarController.isOpen.value);
              },
              child: SvgPicture.asset(
                toolbarController.isOpen.value
                    ? 'assets/icons/chevron_down.svg'
                    : 'assets/icons/chevron_up.svg',
                width: 8.w,
              ),
            )
            // child: IconButton(
            //   icon: FaIcon(
            //     toolbarController.isOpen.value
            //         ? FontAwesomeIcons.arrowDown
            //         : FontAwesomeIcons.arrowUp,
            //     size: 14.sp,
            //     color: Colors.white
            //   ),
            //   onPressed: () {
            //     toolbarController.isOpen(!toolbarController.isOpen.value);
            //     _showMenu(context);
            //   },
            // ),
          ),
        ),
        Container(
          height: toolbarController.isOpen.value ? 74.h : 34.h,
          width: 1.sw,
          decoration: BoxDecoration(
            color: const Color(0xff383838).withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.sp),
              topLeft: Radius.circular(20.sp),
            ),
          ),
          child: toolbarController.isOpen.value
              ? Padding(
                  padding: EdgeInsets.only(top: 12.h, left: 35.w, right: 25.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: SvgPicture.asset(
                          'assets/icons/settings.svg',
                          height: 22.h,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          mainController.activeScreenGetBack();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/chevron_left.svg',
                          height: 25.h,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          mainController.activeScreenGoForward();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/chevron_right.svg',
                          height: 25.h,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showMenu(context);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/menu.svg',
                          height: 32.h,
                          color: toolbarController.isOpenMenu.value
                              ? Color(0xff39F06D)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ],
    ));
  }
}