import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/theme/text_theme.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenShot extends StatefulWidget{
  final Uint8List? screenshotImage;
  const ScreenShot({Key? key, this.screenshotImage}) : super(key: key);

  @override
  State<ScreenShot> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
  final _controller = CropController();
  final MainController mainController = Get.find(tag: 'main');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Crop(
              initialSize: 0.7,
              image: widget.screenshotImage!,
              controller: _controller,
              onCropped: (image) {
                mainController.saveScreenshot(image);
                Get.back();
              },
              // cornerDotBuilder: (size, edgeAlignment) => const DotControl(color: Colors.blue),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: RaisedButton(
                  color: const Color(0xfffffff).withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel',
                      style: font14.copyWith(
                        color: Color(0xff383838),
                        fontSize: 24.sp,
                      )
                  ),
                )
            ),
            Positioned(
                top: 10,
                right: 10,
                child: RaisedButton(
                  color: const Color(0xfffffff).withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                  ),
                  onPressed: () async {
                    var status = await Permission.storage.status;
                    if (status.isGranted){
                      _controller.crop();
                    } else{
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                            title: Text('Allow this app to access photos and videos?'),
                            content: Text(
                                'This devile will be able to access photos and videos while it is connected to your iPhone'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                  child: Text('Allow'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    openAppSettings();
                                  }
                              ),
                              CupertinoDialogAction(
                                child: Text("Don't Allow"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ));
                    }
                  },
                  child: Text(
                      'Save',
                      style: font14.copyWith(
                        color: Color(0xff383838),
                        fontSize: 24.sp,
                      )
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}