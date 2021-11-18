import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:screen_split/cropPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      // home: CropSample(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static GlobalKey previewContainer = GlobalKey();
  int _counter = 0;
  // late ui.Image _image;
  Uint8List? example = null;
  final _controller = CropController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
        key: previewContainer,
        child: Scaffold(
          appBar: AppBar(

            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  // style: Theme.of(context).textTheme.display1,
                ),
                if (example != null)
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Crop(
                        image: example!,
                        controller: _controller,
                        onCropped: (image) {
                          setState(() {
                            example = image;
                          });
                        }
                    ),
                  ),
                // if (example != null)
                //   Image.memory(
                //     Uint8List.fromList(example!),
                //     width: 500,
                //     height: 500,
                //   ),
                RaisedButton(
                  onPressed: takeScreenShot,
                  child: const Text('Take a Screenshot'),
                ),
                RaisedButton(
                  onPressed: (){
                    _controller.crop();
                  },
                  child: const Text('Crop'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }
  takeScreenShot() async{
    final RenderRepaintBoundary boundary = previewContainer.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return takeScreenShot();
    }

    final ui.Image image = await boundary.toImage();
    // setState(() {
    //   _image = image;
    // });
    print(image);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    setState(() {
      example = pngBytes;
    });

    // RenderObject? boundary = previewContainer.currentContext?.findRenderObject();
    // ui.Image image = await boundary.toImage();
    // final directory = (await getApplicationDocumentsDirectory()).path;
    // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List pngBytes = byteData!.buffer.asUint8List();
    // print(pngBytes);
    // File imgFile =new File('$directory/screenshot.png');
    // imgFile.writeAsBytes(pngBytes);
  }
}