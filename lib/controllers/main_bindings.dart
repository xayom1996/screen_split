import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), tag: 'main');
    Get.put<ToolbarController>(ToolbarController(), tag: 'toolbar');
  }
}