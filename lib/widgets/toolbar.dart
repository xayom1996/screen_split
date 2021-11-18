import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/widgets/menu.dart';

class Toolbar extends StatelessWidget{
  final Function onSwapScreens;
  final Function onScreenShot;
  final Function addToFavorites;
  Toolbar({Key? key, required this.onSwapScreens, required this.onScreenShot,
    required this.addToFavorites}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');

  void _showMenu(BuildContext ctx) {
    showCupertinoModalPopup<void>(
        context: ctx,
        builder: (BuildContext context) => Align(
          alignment: Alignment.center,
          child: CupertinoActionSheet(
            actions: <Widget>[
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: const Text('Swap screens', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context);
                    onSwapScreens();
                  },
                ),
              ),
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: const Text('Take a screenshot', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context);
                    onScreenShot();
                  },
                ),
              ),
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: const Text('Назад', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context);
                    mainController.activeScreenGetBack();
                  },
                ),
              ),
              Container(
                color: const Color(0xff383838).withOpacity(0.9),
                child: CupertinoActionSheetAction(
                  child: const Text('Вперед', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context);
                    mainController.activeScreenGoForward();
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
                child: Text('Cancel', style: TextStyle(color: Colors.green),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final ToolbarController toolbarController = Get.find(tag: 'toolbar');

    return Obx(() => Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: (){
            toolbarController.clickedToolbarButton();
          },
          child: Container(
            height: 22.h,
            width: 49.w,
            decoration: BoxDecoration(
              color: const Color(0xff383838).withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.sp),
                  topLeft: Radius.circular(50.sp),
              ),
            ),
            child: IconButton(
              icon: FaIcon(
                toolbarController.isOpen.value
                    ? FontAwesomeIcons.arrowDown
                    : FontAwesomeIcons.arrowUp,
                size: 14.sp,
                color: Colors.white
              ),
              onPressed: () {
                toolbarController.isOpen(!toolbarController.isOpen.value);
                _showMenu(context);
              },
            ),
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
        ),
      ],
    ));
  }
}