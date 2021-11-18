import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenShot extends StatefulWidget{
  final Uint8List? screenshotImage;
  const ScreenShot({Key? key, this.screenshotImage}) : super(key: key);

  @override
  State<ScreenShot> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
  final _controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Crop(
              image: widget.screenshotImage!,
              controller: _controller,
              aspectRatio: 4 / 3,
              // initialSize: 0.5,
              onCropped: (image) {
                print(image);
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
                  child: Text('Cancel'),
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
                  onPressed: () {
                    _controller.crop();
                  },
                  child: Text('Save'),
                )
            ),
          ],
        ),
      )
    );
  }
}