import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/screenshot_page.dart';
import 'package:screen_split/widgets/main_favorites.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplitScreen extends StatelessWidget {
  final int id;

  SplitScreen({Key? key, required this.id}) : super(key: key);

  InAppWebViewController? webView;
  Uint8List? screenshotBytes;

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find(tag: 'main');
    final ToolbarController toolbarController = Get.find(tag: 'toolbar');

    return Obx(() {
      return mainController.urls[id]!.value == ''
        ? GestureDetector(
            onTap: (){
              toolbarController.changeStatus(false);
              mainController.activeScreen(id);
            },
            child: MainFavorites(id: id)
          )
        : Container(
          color: const Color(0xff252525),
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(mainController.urls[id]!.value)),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                  mainController.webViews![id] = webView;
                  mainController.statuses[id]!('loading');
                },
                onLoadStart: (controller, url) {
                },
                onLoadStop: (controller, url) async {
                  mainController.statuses[id]!('');
                },
                onScrollChanged: (InAppWebViewController controller, int x, int y){
                  toolbarController.changeStatus(false);
                  mainController.activeScreen(id);
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  mainController.urls[id]!(url.toString());
                },
              ),

              if (mainController.statuses[id]!.value == 'loading')
                const Center(child: CircularProgressIndicator()),

              if (mainController.isCapture.value && mainController.screenshotBytes![id] != null)
                Image.memory(mainController.screenshotBytes![id]!),
            ],
          ),
        );
    });
  }
}