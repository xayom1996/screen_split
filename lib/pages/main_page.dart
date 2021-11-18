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
  static GlobalKey previewContainer = GlobalKey();
  static ScreenshotController screenshotController = ScreenshotController();
  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');
  final double address1Top = 20;
  final double address2Top = 110;
  bool swapped = false;

  @override
  Widget build(BuildContext context) {
      print ('https://collection.stylesup.io/f9tv4fbjyvewrfj2'.split('/'));

      return Scaffold(
        backgroundColor: Color(0xff383838),
        body: SafeArea(
          child: Stack(
            children: [
              Screenshot(
                controller: screenshotController,
                child: _showScreens()
              ),
              Positioned(
                bottom: 0,
                child: Toolbar(
                  onScreenShot: takeScreenShot,
                  onSwapScreens: swapScreens,
                  addToFavorites: (){},
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Toolbar(
        //   onScreenShot: (){},
        //   onSwapScreens: (){},
        //   addToFavorites: (){},
        // ),
      );
  }

  _showScreens(){
    return Container(
      color: const Color(0xff383838),
      child: Column(
        children: [
          SizedBox(
            height: 360.h,
            child: SplitScreen(id: 1),
          ),
          SizedBox(height: 4.h),
          Container(
            height: 4.h,
            width: 80.w,
            child: RaisedButton(
                color: Colors.white,
                onPressed: (){},
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(2.0)
                )
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: SizedBox(
                // height: 360.h,
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
      Get.to(ScreenShot(screenshotImage: capturedImage));
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