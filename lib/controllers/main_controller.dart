import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  RxBool isCapture = false.obs;
  Map<int, InAppWebViewController?>? webViews = {};
  Map<int, Uint8List?>? screenshotBytes = {};
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

  void changeUrl(int id, String url){
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

}