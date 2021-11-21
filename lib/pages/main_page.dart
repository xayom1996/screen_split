import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/screenshot_page.dart';
import 'package:screen_split/widgets/custom_dialog.dart';
import 'package:screen_split/widgets/custom_snackbar.dart';
import '../widgets/split_screen.dart';
import 'package:screen_split/widgets/toolbar.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:screenshot/screenshot.dart';

class MainPage extends StatefulWidget{
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static ScreenshotController screenshotController = ScreenshotController();
  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');

  @override
  Widget build(BuildContext context) {

      return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          mainController.isPortrait(orientation == Orientation.portrait);

          return Scaffold(
            backgroundColor: Color(0xff383838),
            body: SafeArea(
                child: Obx(() => Stack(
                  alignment: Alignment.center,
                  children: [
                    Screenshot(
                        controller: screenshotController,
                        child: _showScreens()
                    ),
                    if (mainController.isSnackBarShowed.value)
                      Positioned(
                          bottom: 100.h,
                          child: CustomSnackbar()
                      ),
                    if (mainController.isOpenMenu.value)
                      Positioned(
                          bottom: 16.h,
                          child: CustomDialog(
                            onScreenShot: takeScreenShot,
                            onSwapScreens: swapScreens,
                          )
                      ),
                    if (!mainController.isTapFavorite.value && !mainController.isAddToFavorite.value && !mainController.isOpenMenu.value)
                      Positioned(
                        bottom: 0,
                        child: Toolbar(),
                      ),
                  ],
                ),)
            ),
            // bottomNavigationBar: Toolbar(
            //   onScreenShot: (){},
            //   onSwapScreens: (){},
            //   addToFavorites: (){},
            // ),
          );
        },
      );
  }

  _showScreens(){
    return Container(
      color: const Color(0xff383838),
      child: Flex(
        direction: mainController.isPortrait.value ? Axis.vertical : Axis.horizontal,
        children: [
          SizedBox(
            height: mainController.isPortrait.value
                ? MediaQuery.of(context).viewInsets.bottom != 0
                  ? max(300.h, mainController.firstScreenSize.value - MediaQuery.of(context).viewInsets.bottom)
                  : mainController.firstScreenSize.value
                : 1.sh,
            width: !mainController.isPortrait.value
                  ? mainController.firstScreenSize.value
                  : 1.sw,
            child: SplitScreen(id: 1),
          ),
          SizedBox(
              height: mainController.isPortrait.value ? 4.h : null,
              width: mainController.isPortrait.value ? 4.w : null,
          ),
          GestureDetector(
            onPanUpdate: (details){
              double mousePosition = mainController.isPortrait.value
                  ? details.globalPosition.dy - 60.h
                  : details.globalPosition.dx;
              bool checking = mainController.isPortrait.value
                  ? mousePosition >= 200.h && 1.sh - mousePosition >= 300.h
                  : mousePosition >= 90.w && 1.sw - mousePosition >= 90.w;
              print(checking);
              print(1.sw);
              print('${mousePosition} ${200.w}');
              print('${1.sw - mousePosition} ${300.w}');
              if (checking) {
                mainController.firstScreenSize(mousePosition);
              }
            },
            child: Container(
              height: mainController.isPortrait.value ? 5.h : 80.h,
              width: mainController.isPortrait.value ? 80.w: 5.w,
              child: RaisedButton(
                  color: Colors.white,
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(2.0)
                  )
              ),
            ),
          ),
          SizedBox(
            height: mainController.isPortrait.value ? 4.h : null,
            width: mainController.isPortrait.value ? 4.w : null,
          ),
          Expanded(
            child: SizedBox(
                child: SplitScreen(id: 2)
            ),
          ),
        ],
      ),
    );
  }

  takeScreenShot() async{
    await mainController.changeCapture();
    mainController.isCapture(true);
    screenshotController
        .capture(delay: const Duration(milliseconds: 800))
        .then((capturedImage) async {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => ScreenShot(screenshotImage: capturedImage),
          transitionDuration: Duration.zero,
        ),
      );
      await mainController.changeCapture();
      mainController.isCapture(false);
    }).catchError((onError) {
      print(onError);
    });

    // final RenderRepaintBoundary boundary = previewContainer.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    //
    //
    // if (boundary.debugNeedsPaint) {
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   return takeScreenShot();
    // }
    //
    // final ui.Image image = await boundary.toImage();
    // final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // final Uint8List pngBytes = byteData!.buffer.asUint8List();
    //
    // mainController.changeCapture();
    // Get.to(ScreenShot(screenshotImage: pngBytes));
  }

  swapScreens() async {
    await mainController.swapScreens();
  }
}