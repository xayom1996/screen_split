import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class MainController extends GetxController{
  RxBool isCapture = false.obs;
  RxBool isTapFavorite = false.obs;
  RxBool isAddToFavorite = false.obs;
  RxBool isSnackBarShowed = false.obs;
  RxBool isOpenMenu = false.obs;
  RxString snackBarTitle = ''.obs;
  RxString choosingUrl = ''.obs;
  Map<int, InAppWebViewController?>? webViews = {};
  Map<int, Uint8List?>? screenshotBytes = {};
  RxDouble firstScreenSize = 360.h.obs;
  RxBool isPortrait = true.obs;


  Map<int, RxString> urls = {
    1: ''.obs,
    2: ''.obs,
  };
  Map<int, RxString> statuses = {
    1: ''.obs,
    2: ''.obs,
  };
  RxInt activeScreen = 1.obs;

  Future<void> changeCapture() async{
    if (isCapture.value == false){
      if (urls[1]!.value != '') {
        screenshotBytes![1] = await webViews![1]!.takeScreenshot();
      }
      if (urls[2]!.value != '') {
        screenshotBytes![2] = await webViews![2]!.takeScreenshot();
      }
    }
    else{
      screenshotBytes![1] = null;
      screenshotBytes![2] = null;
    }
    isCapture(!isCapture.value);
  }

  Future<void> swapScreens() async{
    if (urls[2]!.value != '' && urls[1]!.value != ''){
      Uri? firstUrl = await webViews![1]!.getUrl();
      Uri? secondUrl = await webViews![2]!.getUrl();

      await webViews![1]!.loadUrl(urlRequest: URLRequest(url: secondUrl));
      await webViews![2]!.loadUrl(urlRequest: URLRequest(url: firstUrl));

      urls[1]!.value = secondUrl.toString();
      urls[2]!.value = firstUrl.toString();
    } else if (urls[2]!.value == ''){
      Uri? firstUrl = await webViews![1]!.getUrl();

      urls[2]!.value = firstUrl.toString();
      urls[1]!.value = '';
    } else if (urls[1]!.value == ''){
      Uri? secondUrl = await webViews![2]!.getUrl();

      urls[1]!.value = secondUrl.toString();
      urls[2]!.value = '';
    }
    activeScreen(activeScreen.value == 1 ? 2 : 1);
  }

  void changeUrl(int id, String url) async{
    if (urls[id]!.value != '') {
      await webViews![id]!.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
    }
    urls[id]!.value = url;
    activeScreen(id);
  }

  void activeScreenGetBack() async{
    try{
      bool canGoBack = await webViews![activeScreen.value]!.canGoBack();
      if (canGoBack) {
        await webViews![activeScreen.value]!.goBack();
      } else {
        urls[activeScreen.value]!.value = '';
      }
    } catch(e){
      print(e);
    }
  }

  void activeScreenGoForward() async{
    try {
      bool canGoForward = await webViews![activeScreen.value]!.canGoForward();
      if (canGoForward) {
        await webViews![activeScreen.value]!.goForward();
      }
    } catch(e){
      print(e);
    }
  }

  void addToFavorites(int id) async {
    isSnackBarShowed(true);
    snackBarTitle('Added to favorites');
    Future.delayed(const Duration(milliseconds: 2500), () {
      isSnackBarShowed(false);
      snackBarTitle('');
    });
  }

  void saveScreenshot(Uint8List img) async {
    try {
      String screenshotName = 'screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      await ImageGallerySaver.saveImage(img, quality: 60, name: screenshotName);
      snackBarTitle('Screenshot saved in your gallery');
    } catch(e){
      snackBarTitle('Something went wrong');
    } finally{
      isSnackBarShowed(true);
      Future.delayed(const Duration(milliseconds: 2500), () {
        isSnackBarShowed(false);
        snackBarTitle('');
      });
    }
  }

  double height(double height) {
    print(1.sw);
    print(1.sh);
    print(40.w);
    print(40.h);
    // I/flutter ( 5705): 392.72727272727275
    // I/flutter ( 5705): 781.0909090909091
    // I/flutter ( 5705): 41.89090909090909
    // I/flutter ( 5705): 38.47738468428124
    // I/flutter ( 5705): 718.9090909090909
    // I/flutter ( 5705): 392.72727272727275
    // I/flutter ( 5705): 76.68363636363635
    // I/flutter ( 5705): 19.346171070309
    return isPortrait.value ? height.h : height.w;
  }

  double width(double width) {
    return isPortrait.value ? width.w : width.h;
  }

}