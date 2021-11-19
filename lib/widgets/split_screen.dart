import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/screenshot_page.dart';
import 'package:screen_split/theme/text_theme.dart';
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

    return Container(
      color: const Color(0xff252525),
      child: Obx(() {
        return Stack(
            children: [
              mainController.urls[id]!.value == ''
              ? GestureDetector(
                  onTap: (){
                    toolbarController.changeStatus(false);
                    mainController.activeScreen(id);
                  },
                  child: MainFavorites(id: id)
              )
              : InAppWebView(
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

              if (mainController.isTapFavorite.value)
                InkWell(
                  onTap: (){
                    mainController.changeUrl(id, mainController.choosingUrl.value);
                    mainController.choosingUrl('');
                    mainController.isTapFavorite(false);
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.65),
                    height: 1.sh,
                    width: 1.sw,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/tap_to_open.svg',
                            height: 71.h,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Tap to\n open here', style: font32, textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                ),
              if (mainController.isAddToFavorite.value && mainController.urls[id]!.value != '')
                InkWell(
                  onTap: (){
                    mainController.addToFavorites(id);
                    mainController.isAddToFavorite(false);
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.65),
                    height: 1.sh,
                    width: 1.sw,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/add_to_favorite.svg',
                            // color: Color(0xffBDBDBD),
                            height: 71.h,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Add to\nfavorites', style: font32, textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          );
      }),
    );
  }
}